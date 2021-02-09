# frozen_string_literal: true

require 'csv'

namespace :merchants do
  desc 'Bulk import merchants from CSV file'
  task :bulk_import_merchants, [:file_path] => :environment do |_, args|
    return unless args[:file_path].present?

    ImportMerchantJob.perform_later(file_path: args[:file_path])
    p '-----------------Added Importing Merchants in background job------------------------'
  end
end
