class Order < ApplicationRecord
	belongs_to :merchant
	belongs_to :customer
	after_initialize :set_default_date
	enum status: { unfulfilled: 'Unfulfilled', pending: 'Pending', fulfilled: 'Fulfilled' }
	# scope :recent -> {order(:created_at, :asc)}

	def set_default_date
		self.date_created = Time.now
	end
end
