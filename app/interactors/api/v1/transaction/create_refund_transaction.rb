# frozen_string_literal: true

module Api
  module V1
    module Transaction
      # This interactor is used for creating refund type transaction
      class CreateRefundTransaction
        include Interactor

        def call
          process_transaction
        end

        private

        def process_transaction
          interactor = interactor_init_class.call(ref_transaction: context.ref_transaction, type: 'Refund',
                                                  ref_type: 'Charge', transaction_params: context.transaction_params)
          refund = interactor.result
          if refund.valid?
            refund.save!
            context.ref_transaction.update(status: :refunded)
            context.transaction = refund
          else
            process_failure_transaction(refund, interactor.valid_ref_transaction)
          end
        end

        def process_failure_transaction(refund, valid_ref_transaction)
          if valid_ref_transaction
            context.fail!(error: refund.errors.full_messages.join(', '))
          else
            response = Api::V1::Transaction::CreateErrorTransaction.call(transaction: refund)
            context.fail!(error: response.error) if response.failure?
          end
        end

        def interactor_init_class
          Api::V1::Transaction::InitializeTransaction
        end
      end
    end
  end
end
