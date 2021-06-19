# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :entity_categories, dependent: :destroy
  has_many :activities, through: :entity_categories, source: :categorizable,
                        source_type: Activity.name

  validates :name, presence: true
end
