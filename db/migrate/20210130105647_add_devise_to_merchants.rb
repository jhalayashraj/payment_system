# frozen_string_literal: true

class AddDeviseToMerchants < ActiveRecord::Migration[6.1]
  def change
    change_table :merchants do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
    end

    add_index :merchants, :email,                unique: true
    add_index :merchants, :reset_password_token, unique: true
  end
end
