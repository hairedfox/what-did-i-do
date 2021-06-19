FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.sentence }
    action_type { Activity.action_types.keys.sample }
    notes { Faker::Lorem.sentence }
  end
end
