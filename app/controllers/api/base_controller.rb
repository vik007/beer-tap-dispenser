# frozen_string_literal: true

# Base controller for API endpoints
module Api
  class BaseController < ApplicationController
    protected

    def response_format(message, data: {}, code: 200)
      render json: { message:, data: }, status: code
    end
  end
end
