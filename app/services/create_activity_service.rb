class CreateActivityService
  attr_reader :params
  attr_accessor :success, :errors, :result

  def initialize(params)
    @params = params
    @success = false
    @errors = []
  end

  def perform
    current_user = RequestStore.store[:current_user]

    ActiveRecord::Base.transaction do
      activity = create_activity!
      current_user.activities << activity
      create_tracker!(activity)
      @result = serialize(activity)
      @success = true
    end

    true
  rescue StandardError => e
    Rails.logger.debug(e)
    @errors << "Something Went Wrong!"
    @success = false
  end

  private

  def create_activity!
    Activity.create!(
      name: params[:name],
      action_type: Activity.action_types[:counting],
      notes: params[:notes]
    )
  end

  def create_tracker!(activity)
    Tracker.create!(
      tracker_type: Tracker.tracker_types[:counter],
      occurred_at: Time.zone.now,
      user_activity_id: activity.user_activities.last.id,
      times: params[:times]
    )
  end

  def serialize(activity)
    ::UserActivitySerializer.new(activity.user_activities.last).as_json
  end
end
