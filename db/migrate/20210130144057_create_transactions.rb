# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def up
    create_enum_transaction_status

    create_table :transactions do |t|
      t.string     :uuid, null: false
      t.decimal    :amount, default: 0.0
      t.column     :status, :transaction_status, null: false
      t.string     :customer_email
      t.string     :customer_phone
      t.string     :type, null: false
      t.references :merchant, foreign_key: true, index: true

      t.timestamps
    end
  end

  def down
    drop_table :transactions

    drop_enum_transaction_status
  end

  def create_enum_transaction_status
    execute <<-SQL
      CREATE TYPE transaction_status AS ENUM ('approved', 'reversed', 'refunded', 'error');
    SQL
  end

  def drop_enum_transaction_status
    execute <<-SQL
      DROP TYPE transaction_status;
    SQL
  end
end
