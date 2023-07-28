# frozen_string_literal: true

FactoryBot.define do
  factory :dispenser do
    flow_volume { 0.1 }
    duration { 3 }
    amount { 10 }
  end
end
