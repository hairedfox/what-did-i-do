# frozen_string_literal: true

class UserActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  has_one :tracker, dependent: :destroy

  before_create :init_start_date

  delegate :times, to: :tracker
  delegate :name, to: :activity

  scope :for_today, lambda {
    where(start_date: Time.zone.today.all_day)
  }

  private

  def init_start_date
    self.start_date = Time.zone.now
  end
end
