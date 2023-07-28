# frozen_string_literal: true

# Represents a beer tap dispenser.
# It has a flow_volume attribute that indicates
# how many liters flow per second when the tap is open.
class Dispenser < ApplicationRecord
  has_many :dispense_events, dependent: :destroy

  validates :flow_volume, presence: true, numericality: { greater_than: 0 }
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :amount, presence: true, numericality: true

  def per_second_volume
    flow_volume.to_f / duration
  end

  def total_volume
    dispense_events.sum(:volume)
  end

  def total_duration
    dispense_events.sum(:duration)
  end

  def total_amount
    dispense_events.sum(:amount)
  end
end
