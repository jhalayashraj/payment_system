# frozen_string_literal: true

class MerchantsController < ApplicationController
  before_action :authenticate_merchant!
  before_action :authenticate_admin, only: [:index]
  before_action :find_merchant, only: %w[show edit update destroy]

  def index
    @merchants = Merchant.ordered.includes(:transactions).paginate(page: params[:page])
  end

  def update
    interactor = UpdateMerchant.call(merchant: @merchant, merchant_params: merchant_params)

    if interactor.success?
      redirect_to @merchant, notice: 'Merchant was successfully updated.'
    else
      @merchant = interactor.merchant
      render :edit
    end
  end

  def destroy
    RemoveMerchant.call(merchant: @merchant)
    redirect_to merchants_url, notice: 'Merchant was successfully destroyed.'
  end

  private

  def find_merchant
    @merchant = Merchant.find_by(id: params[:id])
  end

  def merchant_params
    params.require(:merchant).permit(:name, :email, :description, :status)
  end
end
