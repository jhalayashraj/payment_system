# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions' do
  it 'signs user in and out' do
    merchant = create(:merchant)
    sign_in merchant
    get merchant_url(merchant)
    expect(response).to have_http_status(:success)

    sign_out merchant
    get new_merchant_session_url
    expect(response).to have_http_status(:success)
  end
end
