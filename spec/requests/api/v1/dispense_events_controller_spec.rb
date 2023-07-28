# frozen_string_literal: true

# spec/requests/api/v1/dispense_events_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::DispenseEventsController, type: :request do
  let(:dispenser) { Dispenser.create(flow_volume: 0.2, duration: 20, amount: 10) }

  describe 'POST /open' do
    let(:params) { { dispenser_id: dispenser.id } }

    it 'opens a new dispense event' do
      post '/api/v1/dispense_events/open', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data']['dispenser_id']).to eq(dispenser.id)
    end
  end

  describe 'POST /close' do
    let!(:dispense_event) { DispenseEvent.create(dispenser:, start_time: 1.hour.ago) }
    let(:params) { { dispenser_id: dispenser.id } }

    it 'closes an existing dispense event' do
      post '/api/v1/dispense_events/close', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(200)
    end
  end

  describe 'error handling' do
    let(:params) { { dispenser_id: 45_646_546 } }
    it 'returns error if dispenser not found for open endpoint' do
      post '/api/v1/dispense_events/open', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)['message']).to eq('Not Found')
    end

    it 'returns error if dispenser not found for close endpoint' do
      post '/api/v1/dispense_events/close', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)['message']).to eq('Not Found')
    end
  end

  describe 'error handling for already open' do
    let(:params) { { dispenser_id: dispenser.id } }
    it 'returns error if dispenser is not already open' do
      post '/api/v1/dispense_events/open', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      expect(response).to have_http_status(200)

      post '/api/v1/dispense_events/open', params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)['message']).to eq('Dispenser already open.')
    end
  end
end
