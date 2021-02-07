# frozen_string_literal: true

module Api
  module V1
    module Transaction
      # This interactor is used for creating authorize type transaction
      class CreateAuthorizeTransaction
        include Interactor

        def call
          process_transaction
        end

        private

        def process_transaction
          transaction = Transactions::Authorize.new(context.transaction_params)
          transaction.status = 'approved'
          if transaction.valid?
            transaction.save!
            context.transaction = transaction
          else
            context.fail!(error: transaction.errors.full_messages.join(', '))
          end
        end
      end
    end
  end
end
