# frozen_string_literal: true

class UserActivitiesController < BaseController
  def index
    @user_activities = UserActivity.for_today
  end

  def create
    service = CreateActivityService.new(params)
    service.perform

    render json: service.result, status: :ok
  end

  def update
    service = if request.patch?
                UserActivityServices::UpdateSingleAttributeService.new(params)
              else
                UserActivityServices::UpdateService.new(params)
              end

    service.perform

    render json: service.result, status: :ok
  end

  def destroy
    user_activity = UserActivity.for_today.find(params[:id])

    user_activity.destroy

    render json: { success: true }, status: :ok
  end
end
