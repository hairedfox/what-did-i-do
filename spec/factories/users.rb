# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Password1@' }
    nickname { Faker::Name.first_name }
  end
end
