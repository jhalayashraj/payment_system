# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts '*********Merchant and Admin Creation Started*********'
Merchant.find_or_create_by(name: 'Admin', email: 'admin@yopmail.com', status: :active, role: :admin) do |admin|
  admin.password = 'admin123'
end
Merchant.find_or_create_by(name: 'Merchant', email: 'merchant@yopmail.com', status: :active, role: :merchant) do |merchant|
  merchant.password = 'merchant123'
end
puts '********Merchant and Admin Creation Completed********'
