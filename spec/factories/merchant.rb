# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    email { Faker::Internet.email }
    reference { Faker::Company.name }
  end
end
