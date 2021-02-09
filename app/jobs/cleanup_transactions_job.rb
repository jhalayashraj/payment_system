# frozen_string_literal: true

class CleanupTransactionsJob < ApplicationJob
  queue_as :default

  def perform(period:)
    CleanupTransactionsService.perform(period: period)
  end
end
