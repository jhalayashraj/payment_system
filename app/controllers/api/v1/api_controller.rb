# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::Base
      before_action :authenticate_request
      protect_from_forgery prepend: true

      private

      def authenticate_request
        interactor = Api::V1::AuthenticateApiRequest.call(headers: request.headers)
        if interactor.success?
          @current_merchant = interactor.merchant
        else
          render json: { error: interactor.error }, status: 401
        end
      end
    end
  end
end
