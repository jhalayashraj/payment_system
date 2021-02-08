# frozen_string_literal: true

module Merchants
  # This interactor is used for updating merchant
  class UpdateMerchant
    include Interactor

    def call
      merchant = context.merchant
      if merchant.update(context.merchant_params)
        context.merchant = merchant
      else
        context.fail!
      end
    end
  end
end
