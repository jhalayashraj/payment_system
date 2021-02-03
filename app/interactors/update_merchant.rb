# frozen_string_literal: true

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
