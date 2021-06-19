# frozen_string_literal: true

class CreateActivityService < BaseService
  attr_reader :params

  def initialize(params)
    super()
    @params = params
  end

  def perform
    ActiveRecord::Base.transaction do
      activity = create_activity!
      create_user_activity!(activity)
      create_tracker!(activity)
      @result = serialize(activity).merge(success: true)
    end

    true
  rescue StandardError => e
    handle_error(e)
  end

  private

  def create_activity!
    Activity.find_by(name: params[:name]) ||
      Activity.create!(
        name: params[:name],
        action_type: Activity.action_types[:counting]
      )
  end

  def create_user_activity!(activity)
    return unless activity

    if tracked_today?(activity)
      user_activities_today(activity).last.update!(notes: params[:notes])
      return
    end

    UserActivity.create!(
      user: current_user,
      activity: activity,
      notes: params[:notes]
    )
  end

  def create_tracker!(activity)
    return unless activity

    tracker = activity.user_activities.for_today.last.tracker

    tracker.update!(times: tracker.times + params[:times].to_i) && return if tracker

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

  def user_activities_today(activity)
    activity.user_activities.for_today
  end

  def tracked_today?(activity)
    activity.user_activities.for_today.present?
  end
end
