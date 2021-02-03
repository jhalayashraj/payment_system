# frozen_string_literal: true

class RemoveMerchant
  include Interactor

  def call
    merchant = context.merchant
    merchant.destroy
  end
end
