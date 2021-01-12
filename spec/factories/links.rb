# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :link do
    url { 'http://www.google.com' }
    slug { Faker::Name.unique.first_name }
  end
end
