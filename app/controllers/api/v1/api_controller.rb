# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::Base
      before_action :authenticate_request
      protect_from_forgery prepend: true

      rescue_from Exception, with: :server_error
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActionController::MethodNotAllowed, with: :method_not_allowed

      private

      def authenticate_request
        interactor = Api::V1::AuthenticateApiRequest.call(headers: request.headers)
        if interactor.success?
          @current_merchant = interactor.merchant
        else
          render json: { error: interactor.error }, status: 401
        end
      end

      def server_error(exception)
        Rails.logger.error(exception)
        render json: { message: 'Internal server error' }, status: :internal_server_error
      end

      def record_not_found
        render json: { message: 'The requested resource was not found' }, status: :not_found
      end

      def method_not_allowed
        render json: { error: 'method not allowed' }, status: :method_not_allowed
      end
    end
  end
end
