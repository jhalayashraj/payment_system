# frozen_string_literal: true

module Api
  module V1
    module Transaction
      # This interactor is used for creating transactions based on the type
      class CreateTransaction
        include Interactor

        def call
          interactor = process_transaction if valid_merchant
          if interactor.success?
            context.transaction = interactor.transaction
          else
            context.fail!(error: interactor.error)
          end
        end

        private

        def process_transaction
          transaction_type = context.transaction_params[:type]&.downcase
          if ApplicationHelper::TRANSACTION_TYPES.include?(transaction_type)
            resource_class(transaction_type).call(transaction_params: transaction_params,
                                                  ref_transaction: context.ref_transaction)
          else
            context.fail!(error: 'Invalid Transaction Type!')
          end
        end

        def resource_class(transaction_type)
          "Api::V1::Transaction::Create#{transaction_type&.capitalize}Transaction".constantize
        end

        def transaction_params
          context.transaction_params.delete(:type)
          context.transaction_params
        end

        def valid_merchant
          context.fail!(error: 'Merchant is not active!') if context.merchant.inactive?
          return true if context.merchant.id.eql?(context.transaction_params[:merchant_id]&.to_i)

          context.fail!(error: 'Merchant Id is not valid!')
        end
      end
    end
  end
end
