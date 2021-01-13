# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    url { 'http://www.google.com' }
    slug { Faker::Name.unique.first_name }
  end
end
