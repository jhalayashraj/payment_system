# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApiController
      before_action :find_referenced_transaction

      def create
        interactor = Api::V1::Transaction::CreateTransaction.call(merchant: @current_merchant,
                                                                  ref_transaction: @ref_transaction,
                                                                  transaction_params: transaction_params)

        if interactor.success?
          render json: { data: interactor.transaction, message: 'Transaction processed successfully!' }
        else
          render json: { errors: interactor.error }, status: :unprocessable_entity
        end
      end

      private

      def transaction_params
        params.require(:transaction).permit(:uuid, :amount, :customer_email, :customer_phone, :type, :merchant_id,
                                            :transaction_id)
      end

      def find_referenced_transaction
        @ref_transaction = @current_merchant.transactions.find_by(id: transaction_params[:transaction_id])
      end
    end
  end
end
