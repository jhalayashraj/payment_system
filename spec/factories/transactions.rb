# frozen_string_literal: true

FactoryBot.define do
  factory :transaction, aliases: [:authorized_transaction], class: Transactions::Authorize do
    association :merchant
    uuid { SecureRandom.hex(6) }
    amount { 100 }
    status { 'approved' }
    customer_email { 'customera@yopmail.com' }
  end

  factory :charge_transaction, class: Transactions::Charge do
    association :merchant
    uuid { SecureRandom.hex(6) }
    amount { 100 }
    status { 'approved' }
    customer_email { 'customerb@yopmail.com' }
  end

  factory :reversal_transaction, class: Transactions::Reversal do
    association :merchant
    uuid { SecureRandom.hex(6) }
    amount { 100 }
    status { 'reversed' }
    customer_email { 'customerc@yopmail.com' }
  end

  factory :refund_transaction, class: Transactions::Refund do
    association :merchant
    uuid { SecureRandom.hex(6) }
    amount { 100 }
    status { 'refunded' }
    customer_email { 'customerd@yopmail.com' }
  end
end
