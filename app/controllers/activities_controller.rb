class ActivitiesController < ApplicationController
  def index
    @activities = Activity.for_today
  end
end
