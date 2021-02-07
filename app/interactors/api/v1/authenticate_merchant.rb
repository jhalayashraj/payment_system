# frozen_string_literal: true

module Api
  module V1
    # This interactor is used for authenticating the merchant
    class AuthenticateMerchant
      include Interactor

      def call
        token = JsonWebTokenService.encode(merchant_id: merchant.id) if merchant.present?
        context.token = token if token.present?
      end

      private

      def merchant
        merchant = Merchant.find_by(email: context.email)
        return merchant if merchant&.valid_password?(context.password)

        context.fail!(error: 'Invalid email/password!')
      end
    end
  end
end
