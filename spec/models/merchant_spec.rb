# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  subject { build(:merchant) }

  it { expect(subject).to be_valid }

  describe 'Associations' do
    it { should have_many(:transactions).dependent(:restrict_with_exception) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it do
      is_expected.to define_enum_for(:status).with_values(
        inactive: 'inactive',
        active: 'active'
      ).backed_by_column_of_type(:enum)
    end

    it { should allow_values(:inactive, :active).for(:status) }
  end
end
