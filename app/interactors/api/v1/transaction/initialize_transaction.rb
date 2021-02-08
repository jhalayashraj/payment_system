# frozen_string_literal: true

module Api
  module V1
    module Transaction
      # This interactor is used for initializing the transaction based on the type and reference
      # Used for validating the reference transaction as well
      class InitializeTransaction
        include Interactor

        def call
          context.result = init_transaction
          context.valid_ref_transaction = validate_reference_transaction(context.ref_transaction)
        end

        private

        def init_transaction
          if validate_reference_transaction(context.ref_transaction)
            assign_transaction_settings
          else
            "Transactions::#{context.type}".constantize.new(uuid: context.transaction_params[:uuid], status: :error,
                                                            merchant_id: context.transaction_params[:merchant_id])
          end
        end

        def assign_transaction_settings
          transaction = context.ref_transaction.dup.becomes("Transactions::#{context.type}".constantize)
          transaction.type = "Transactions::#{context.type}"
          transaction.uuid = context.transaction_params[:uuid]
          transaction
        end

        def validate_reference_transaction(ref_transaction)
          ref_transaction.present? && ref_transaction.approved? &&
            ref_transaction.type.eql?("Transactions::#{context.ref_type}")
        end
      end
    end
  end
end
