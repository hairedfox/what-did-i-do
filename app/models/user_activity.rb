# frozen_string_literal: true

class UserActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  has_many :trackers, dependent: :destroy

  before_create :init_start_date

  private

  def init_start_date
    self.start_date = Time.zone.now
  end
end
