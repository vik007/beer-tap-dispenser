# frozen_string_literal: true

FactoryBot.define do
  factory :dispense_event do
    dispenser
    start_time { 1.hour.ago }
    end_time { Time.now }
  end
end
