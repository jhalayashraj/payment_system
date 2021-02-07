# frozen_string_literal: true

module Api
  module V1
    module Transaction
      # This interactor is used for generating the error for transactions
      class CreateErrorTransaction
        include Interactor

        def call
          generate_error_transaction
        end

        private

        def generate_error_transaction
          if context.transaction.errors[:uuid].present?
            context.fail!(error: 'Uuid has already been taken!')
          else
            context.transaction.save!(validate: false)
            context.fail!(error: 'Approved Referenced Transaction not found!')
          end
        end
      end
    end
  end
end
