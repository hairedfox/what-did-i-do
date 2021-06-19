# frozen_string_literal: true

class Tracker < ApplicationRecord
  belongs_to :user_activity

  validates :tracker_type, :occurred_at, :times, presence: true

  enum tracker_type: {
    counter: 'counter'
  }
end
