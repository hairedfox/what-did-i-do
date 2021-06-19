# frozen_string_literal: true

class Activity < ApplicationRecord
  validates :name, :action_type, presence: true

  enum action_type: {
    counting: 'counting'
  }
end
