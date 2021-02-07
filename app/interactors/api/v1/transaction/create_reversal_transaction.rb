# frozen_string_literal: true

module Api
  module V1
    module Transaction
      # This interactor is used for creating reversal type transaction
      class CreateReversalTransaction
        include Interactor

        def call
          process_transaction
        end

        private

        def process_transaction
          interactor = interactor_init_class.call(ref_transaction: context.ref_transaction, type: 'Reversal',
                                                  ref_type: 'Authorize', transaction_params: context.transaction_params)
          reversal = interactor.result
          if reversal.valid?
            reversal.save!
            context.ref_transaction.update(status: :reversed)
            context.transaction = reversal
          else
            process_failure_transaction(reversal, interactor.valid_ref_transaction)
          end
        end

        def process_failure_transaction(reversal, valid_ref_transaction)
          if valid_ref_transaction
            context.fail!(error: reversal.errors.full_messages.join(', '))
          else
            response = Api::V1::Transaction::CreateErrorTransaction.call(transaction: reversal)
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
