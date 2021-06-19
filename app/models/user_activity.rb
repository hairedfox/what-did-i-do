# frozen_string_literal: true

class UserActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  before_create :init_start_date

  private

  def init_start_date
    self.start_date = Time.zone.now
  end
end
