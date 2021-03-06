# frozen_string_literal: true

FactoryBot.define do
  factory :user_activity do
    activity { nil }
    user { nil }
    notes { Faker::Lorem.sentence }
  end
end
