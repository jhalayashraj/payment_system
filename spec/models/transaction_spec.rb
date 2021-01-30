# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject { build(:transaction) }

  it { expect(subject).to be_valid }

  describe 'Associations' do
    it { should belong_to(:merchant).class_name('Merchant') }
  end

  describe 'Validations' do
    it { should validate_presence_of(:uuid) }
    it { should validate_presence_of(:customer_email) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }

    it do
      is_expected.to define_enum_for(:status).with_values(
        approved: 'approved',
        reversed: 'reversed',
        refunded: 'refunded',
        error: 'error'
      ).backed_by_column_of_type(:enum)
    end

    it { should allow_values(:approved, :reversed, :refunded, :error).for(:status) }
  end
end
