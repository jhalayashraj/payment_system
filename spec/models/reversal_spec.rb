# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactions::Reversal, type: :model do
  subject { build(:reversal_transaction) }

  it { expect(subject).to be_valid }
  it { expect(described_class.superclass).to eq Transaction }
end
