# frozen_string_literal: true

FactoryBot.define do
  factory :stock do
    name { 'Test Stock' }
    association :bearer, factory: :bearer
  end
end