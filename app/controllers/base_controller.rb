# frozen_string_literal: true

class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  private

  def set_current_user
    RequestStore.store[:current_user] ||= current_user
  end
end
