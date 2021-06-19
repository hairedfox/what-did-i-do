# frozen_string_literal: true

module UserActivityServices
  class UpdateSingleAttributeService < BaseService
    attr_reader :params

    def initialize(params)
      super()
      @params = params
    end

    def perform
      attribute = attribute_to_update
      ActiveRecord::Base.transaction do
        raise ArgumentError, 'Not implemented yet!' unless attribute.keys.include?('times')
        tracker = user_activity.tracker
        tracker.update!(times: tracker.times + params[:times].to_i)
        @result = serialize(user_activity).merge(success: true)
      end
    end

    private

    def user_activity
      UserActivity.find(params[:id])
    end

    def attribute_to_update
      params.slice(*UserActivity::UPDATABLE_ATTRIBUTES)
    end

    def serialize(user_activity)
      UserActivitySerializer.new(user_activity).as_json
    end
  end
end
