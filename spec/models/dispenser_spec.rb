# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dispenser, type: :model do
  describe 'associations' do
    it { should have_many(:dispense_events).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:flow_volume) }
    it { should validate_numericality_of(:flow_volume).is_greater_than(0) }

    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration).is_greater_than(0) }

    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount) }
  end

  describe '#per_second_volume' do
    it 'calculates volume per second' do
      dispenser = Dispenser.new(flow_volume: 3, duration: 60)
      expect(dispenser.per_second_volume).to eq(0.05)
    end
  end
end
