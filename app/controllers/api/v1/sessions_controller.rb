# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApiController
      skip_before_action :authenticate_request

      def sign_in
        interactor = Api::V1::AuthenticateMerchant.call(email: params[:email], password: params[:password])

        if interactor.success?
          render json: { auth_token: interactor.token }
        else
          render json: { error: interactor.error }, status: :unauthorized
        end
      end
    end
  end
end
