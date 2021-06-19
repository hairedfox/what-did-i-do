class ActivitiesController < BaseController
  def index
    @activities = Activity.for_today
  end
end
