# frozen_string_literal: true

class AddColumnRoleToMerchant < ActiveRecord::Migration[6.1]
  def up
    create_enum_user_role
    add_column :merchants, :role, :user_role, default: :merchant, null: false
  end

  def down
    remove_column :merchants, :role
    drop_enum_user_role
  end

  def create_enum_user_role
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('merchant', 'admin');
    SQL
  end

  def drop_enum_user_role
    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end
