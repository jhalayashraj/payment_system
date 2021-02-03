# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { 'Merchant A' }
    description { 'Merchant description' }
    email { 'merchanta@yopmail.com' }
    password { SecureRandom.hex(6) }
    status { 'active' }
    total_transaction_sum { 10.0 }
    role { 'merchant' }
  end

  factory :admin, class: 'Merchant' do
    name { 'Admin' }
    description { 'Admin description' }
    email { 'admin@yopmail.com' }
    password { SecureRandom.hex(6) }
    status { 'active' }
    total_transaction_sum { 10.0 }
    role { 'admin' }
  end
end
