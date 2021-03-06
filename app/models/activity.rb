# frozen_string_literal: true

class Activity < ApplicationRecord
  has_many :user_activities, dependent: :destroy
  has_many :users, through: :user_activities
  has_many :entity_categories, as: :categorizable, dependent: :destroy
  has_many :categories, through: :entity_categories

  validates :name, :action_type, presence: true
  validates :name, uniqueness: { case_sensitive: true }

  enum action_type: {
    counting: 'counting'
  }
end
