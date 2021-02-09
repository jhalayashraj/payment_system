# frozen_string_literal: true

class CleanupTransactionsService
  def self.perform(period:)
    Transaction.past_transactions(period).destroy_all
  end
end
