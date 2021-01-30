# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[6.1]
  def up
    create_enum_merchant_status

    create_table :merchants do |t|
      t.string  :name
      t.text    :description
      t.string  :email, null: false
      t.column  :status, :merchant_status, default: :inactive, null: false
      t.decimal :total_transaction_sum, default: 0.0

      t.timestamps
    end
  end

  def down
    drop_table :merchants

    drop_enum_merchant_status
  end

  private

  def create_enum_merchant_status
    execute <<-SQL
      CREATE TYPE merchant_status AS ENUM ('inactive', 'active');
    SQL
  end

  def drop_enum_merchant_status
    execute <<-SQL
      DROP TYPE merchant_status;
    SQL
  end
end
