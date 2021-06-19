# frozen_string_literal: true

class UserActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :user
end
