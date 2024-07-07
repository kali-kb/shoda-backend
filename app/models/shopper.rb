class Shopper < ApplicationRecord
	has_secure_password
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
	has_many :bag_item, foreign_key: :shopper_id
	has_one :customer, dependent: :destroy
	
	private

		def password_required?
			new_record? || password.present?
		end
end
