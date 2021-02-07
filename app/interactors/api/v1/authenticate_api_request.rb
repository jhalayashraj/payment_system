# frozen_string_literal: true

module Api
  module V1
    # This interactor is used for authenticating the API request
    class AuthenticateApiRequest
      include Interactor

      def call
        merchant = authenticate_merchant
        if merchant.present?
          context.merchant = merchant
        else
          context.fail!(error: 'Invalid Authorization token!')
        end
      end

      private

      def authenticate_merchant
        Merchant.find(auth_token[:merchant_id]) if auth_token.present?
      end

      def auth_token
        JsonWebTokenService.decode(http_token)
      end

      def http_token
        return context.headers['Authorization'].split(' ').last if context.headers['Authorization'].present?

        context.fail!(error: 'Missing authorization token!')
      end
    end
  end
end
