class Customer < ApplicationRecord
	belongs_to :shopper
	validates :shopper_id, uniqueness: true
	has_many :order, dependent: :destroy, foreign_key: :customer_id
end
