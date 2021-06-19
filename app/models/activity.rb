class Activity < ApplicationRecord
  validates :name, :action_type, presence: true

  enum action_type: {
    counting: "counting"
  }
end
