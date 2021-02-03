# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_merchant!

  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      merchants_path
    elsif resource.merchant?
      merchant_path(resource)
    end
  end

  def authenticate_admin
    return if current_merchant.present? && current_merchant.admin?

    flash[:alert] = "You don't have permission"
    redirect_to merchant_path(current_merchant)
  end
end
