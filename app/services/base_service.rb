# frozen_string_literal: true

class BaseService
  attr_accessor :errors, :result

  def initialize
    @errors = []
  end

  private

  def current_user
    @current_user ||= RequestStore.store[:current_user]
  end

  def handle_error(err)
    Rails.logger.debug(err)
    @result = {
      success: false,
      errors: ['Something went wrong!'],
      data: nil
    }
  end
end
