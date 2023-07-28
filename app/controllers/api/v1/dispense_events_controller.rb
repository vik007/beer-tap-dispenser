# frozen_string_literal: true

# Provides endpoints for starting and stopping dispense events
module Api
  module V1
    class DispenseEventsController < Api::BaseController
      skip_before_action :verify_authenticity_token
      before_action :set_dispenser
      before_action :set_dispense_event, only: :close

      def open
        dispense_event = @dispenser.dispense_events.create(start_time: Time.now)
        if dispense_event.errors.blank?
          response_format('Dispenser Open', data: dispense_event.response_json, code: 200)
        else
          response_format(dispense_event.errors.full_messages.join(','), data: {}, code: 422)
        end
      end

      def close
        if @dispense_event.update(end_time: Time.now)
          response_format('Dispenser Close', data: {}, code: 200)
        else
          response_format(@dispense_event.errors.full_messages.join(','), data: {}, code: 422)
        end
      end

      private

      def set_dispense_event
        @dispense_event = @dispenser.dispense_events.open.last

        return response_format('Not Found', data: {}, code: 422) unless @dispense_event.present?
      end

      def set_dispenser
        @dispenser = Dispenser.find_by_id(params[:dispenser_id])

        return response_format('Not Found', data: {}, code: 422) unless @dispenser.present?
      end
    end
  end
end
