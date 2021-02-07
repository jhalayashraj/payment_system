# frozen_string_literal: true

module Api
  module V1
    module Transaction
      # This interactor is used for creating charge type transaction
      class CreateChargeTransaction
        include Interactor

        def call
          process_transaction
        end

        private

        def process_transaction
          interactor = interactor_class('InitializeTransaction').call(ref_transaction: context.ref_transaction,
                                                                      type: 'Charge', ref_type: 'Authorize',
                                                                      transaction_params: context.transaction_params)
          charge = interactor.result
          if charge.valid?
            charge.save!
            context.transaction = charge
          else
            process_failure_transaction(charge, interactor.valid_ref_transaction)
          end
        end

        def process_failure_transaction(charge, valid_ref_transaction)
          if valid_ref_transaction
            context.fail!(error: charge.errors.full_messages.join(', '))
          else
            response = interactor_class('CreateErrorTransaction').call(transaction: charge)
            context.fail!(error: response.error) if response.failure?
          end
        end

        def interactor_class(name)
          "Api::V1::Transaction::#{name}".constantize
        end
      end
    end
  end
end
