# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DispenseEvent, type: :model do
  let(:dispenser) { Dispenser.create(flow_volume: 0.2, duration: 20, amount: 10) }

  describe 'associations' do
    it { should belong_to(:dispenser) }
  end

  describe 'validations' do
    it { should validate_presence_of(:dispenser_id) }
    it { should validate_presence_of(:start_time) }
  end

  describe 'callbacks' do
    it 'calculates duration, volume and amount before save' do
      start_time = 1.hour.ago
      end_time = Time.now

      dispense_event = DispenseEvent.new(dispenser:, start_time:, end_time:)
      expect(dispense_event.duration).to eq(0)
      expect(dispense_event.volume).to eq(0)
      expect(dispense_event.amount).to eq(0)

      dispense_event.save
      expect(dispense_event.duration).to eq(3600)
      expect(dispense_event.volume).to eq(36)
      expect(dispense_event.amount).to eq(1800)
    end
  end

  describe 'validations' do
    it 'validates start time is not after end time' do
      start_time = Time.now
      end_time = 1.hour.ago

      dispense_event = DispenseEvent.new(dispenser:, start_time:, end_time:)
      dispense_event.valid?

      expect(dispense_event.errors[:start_time]).to include('start time can not be greater than end time.')
    end

    it 'validates dispenser is not already open' do
      start_time = 2.hours.ago
      DispenseEvent.create(dispenser:, start_time:)
      start_time = 1.hour.ago
      dispense_event_two = DispenseEvent.new(dispenser:, start_time:)
      dispense_event_two.valid?
      expect(dispense_event_two.errors[:dispenser]).to include('already open.')
    end
  end
end
