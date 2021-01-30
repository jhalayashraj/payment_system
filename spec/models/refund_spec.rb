# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactions::Refund, type: :model do
  subject { build(:refund_transaction) }

  it { expect(subject).to be_valid }
  it { expect(described_class.superclass).to eq Transaction }
end
