# frozen_string_literal: true

module Merchants
  # This interactor is used for removing the merchant
  class RemoveMerchant
    include Interactor

    def call
      merchant = context.merchant
      merchant.destroy
    end
  end
end
