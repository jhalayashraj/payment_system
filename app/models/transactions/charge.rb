# frozen_string_literal: true

module Transactions
  class Charge < Transaction
    ## Callbacks
    after_create_commit :update_merchant_amount, if: :approved?

    def update_merchant_amount
      merchant.update(total_transaction_sum: merchant.total_transaction_sum + amount)
    end
  end
end
