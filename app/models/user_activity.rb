# frozen_string_literal: true

class UserActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  has_one :tracker, dependent: :destroy

  before_create :init_start_date

  delegate :times, to: :tracker
  delegate :name, :notes, to: :activity

  scope :for_today, -> do
    where(start_date: Date.today.all_day)
  end

  private

  def init_start_date
    self.start_date = Time.zone.now
  end
end
