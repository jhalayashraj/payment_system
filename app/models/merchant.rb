# frozen_string_literal: true

class Merchant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  ## Relationships
  has_many :transactions, dependent: :restrict_with_exception

  ## Enum
  enum status: { inactive: 'inactive', active: 'active' }
  enum role: { merchant: 'merchant', admin: 'admin' }

  ## Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :status, inclusion: { in: statuses.keys }

  ## Scope
  scope :ordered, -> { order('created_at') }
end
