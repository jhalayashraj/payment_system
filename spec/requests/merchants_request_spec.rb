# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MerchantsController', type: :request do
  let(:merchant) { create :merchant }
  let(:admin) { create :admin }

  before { sign_in admin }

  describe 'GET /show' do
    it 'returns the information for the merchant' do
      get merchant_url(merchant)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_merchant_url(merchant)
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    context 'with valid params' do
      let(:valid_params) do
        { name: 'Updated Merchant' }
      end

      it 'updates the merchant' do
        expect { patch merchant_url(merchant), params: { merchant: valid_params } }
          .to change { merchant.reload.name }.to('Updated Merchant')
        expect(response).to redirect_to(merchant_url(merchant))
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        { name: '' }
      end
      it 'renders a edit page' do
        patch merchant_url(merchant), params: { merchant: invalid_params }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the merchant and redirects' do
      delete merchant_url(merchant)
      expect(response).to redirect_to(merchants_url)
    end
  end
end
