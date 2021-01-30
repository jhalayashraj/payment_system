# frozen_string_literal: true

class Transaction < ApplicationRecord
  ## Relationships
  belongs_to :merchant

  ## Enum
  enum status: { approved: 'approved', reversed: 'reversed', refunded: 'refunded', error: 'error' }

  ## Validations
  validates :uuid, :customer_email, presence: true
  validates :status, inclusion: { in: statuses.keys }, presence: true
  validates :amount, numericality: { greater_than: 0 }, presence: true
end
