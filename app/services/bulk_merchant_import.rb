# frozen_string_literal: true

class BulkMerchantImport
  attr_reader :file_name, :file_name_with_path

  def initialize(merchant_csv_file:)
    @file_name_with_path = merchant_csv_file
    @file_name = "merchant_#{Time.now.to_i}"
  end

  def create_temp_table
    <<~SQL
      CREATE UNLOGGED TABLE #{file_name}
      (
        name varchar NOT NULL,
        email varchar NOT NULL,
        status merchant_status NOT NULL,
        role user_role NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    SQL
  end

  def copy_data_to_temp_table(conn)
    rc = conn.raw_connection
    rc.exec("COPY #{file_name} (name, email, status, role) FROM STDIN WITH HEADER CSV")

    file = File.open(file_name_with_path, 'r')
    rc.put_copy_data(file.readline) until file.eof?

    rc.put_copy_end
  end

  def update_merchant_table
    <<~SQL
      insert into merchants(name, email, status, role, created_at, updated_at)
      select name, email, status, role, created_at, updated_at
      from #{file_name}
      on conflict (email) do nothing
      returning merchants.id
    SQL
  end

  def drop_tmp_table
    <<~SQL
      DROP table #{file_name}
    SQL
  end

  def start_bulk_import
    conn = ActiveRecord::Base.connection
    conn.execute(create_temp_table)
    copy_data_to_temp_table(conn)
    conn.execute(update_merchant_table)
  ensure
    conn.execute(drop_tmp_table)
  end
end
