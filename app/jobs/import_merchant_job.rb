# frozen_string_literal: true

class ImportMerchantJob < ApplicationJob
  queue_as :default

  def perform(file_path:)
    BulkMerchantImportService.new(merchant_csv_file: file_path).start_bulk_import
  end
end
