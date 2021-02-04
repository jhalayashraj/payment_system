# frozen_string_literal: true

require 'csv'

namespace :merchants do
  desc 'Bulk import merchants from CSV file'
  task :bulk_import_merchants, [:file_path] => :environment do |_, args|
    return unless args[:file_path].present?

    p '--------------------Started Importing Merchants------------------------'
    BulkMerchantImportService.new(merchant_csv_file: args[:file_path]).start_bulk_import
    p '-------------------Completed Importing Merchants------------------------'
  end
end
