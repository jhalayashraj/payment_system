# frozen_string_literal: true

class CleanupTransactionsJob < ApplicationJob
  queue_as :default

  def perform(period:)
    Transaction.past_transactions(period).destroy_all
  rescue StandardError => e
    puts "----ERROR: #{e.message}"
  end
end
