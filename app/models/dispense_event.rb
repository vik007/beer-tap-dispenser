# frozen_string_literal: true

# Tracks each time a dispenser is used. Records the start/end times and
# calculates the duration and amount dispensed.
class DispenseEvent < ApplicationRecord
  belongs_to :dispenser

  before_save :complete_tracking

  scope :open, -> { where(end_time: nil) }

  validates :dispenser_id, presence: true
  validates :start_time, presence: true
  validate :already_open, on: :create
  validate :valid_start_end_time

  def response_json
    {
      id:,
      dispenser_id:
    }
  end

  def display_time_interval
    "#{start_time.strftime('%d %b %Y %H:%M')} - #{end_time&.strftime('%d %b %Y %H:%M')}"
  end

  private

  def valid_start_end_time
    return unless start_time? && end_time? && start_time > end_time

    errors.add(:start_time, 'start time can not be greater than end time.')
  end

  def already_open
    return unless dispenser.present? && dispenser.dispense_events.open.exists?

    errors.add(:dispenser, 'already open.')
  end

  def complete_tracking
    return unless end_time? && start_time? && (end_time_changed? || start_time_changed?)

    self.duration = (end_time - start_time)
    self.volume = duration.to_f * dispenser.per_second_volume.to_f
    self.amount = (duration.to_f / dispenser.duration) * dispenser.amount.to_f
  end
end
