# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.sentence }
    action_type { Activity.action_types.keys.sample }
  end
end
