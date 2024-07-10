class Merchant < ApplicationRecord
	has_secure_password
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence:true
	has_many :product , dependent: :destroy, foreign_key: :merchant_id
	has_many :discount , dependent: :destroy, foreign_key: :merchant_id
	has_many :order, dependent: :destroy, foreign_key: :merchant_id
	has_many :notification, dependent: :destroy, foreign_key: :merchant_id
	# has_many :customer
	has_many :customer, through: :order

	def customer_with_shoppers
		customer.includes(:shopper)
	end

end

