# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    url { "www.googe.ie" }
    slug { ::Faker::Name.unique.name.truncate(4) }
  end
end
