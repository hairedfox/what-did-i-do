class UserActivitiesController < BaseController
  def index
    @user_activities = UserActivity.for_today
  end

  def create
    service = CreateActivityService.new(params)
    service.perform

    if service.success
      render json: { success: true, data: service.result }, status: :ok
    else
      render json: { success: false, data: nil, errors: service.errors }, status: :ok
    end
  end
end
