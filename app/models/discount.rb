class Discount < ApplicationRecord
	belongs_to :merchant
	# has_one :product, through: :product, source: :product
	belongs_to :product, foreign_key: :product_id #strict_loading: true

	# def discounted_product
		# Product.find_by(product_id: self.product_id)
	# end
	def as_json(options = {})
		super(options.merge({
			methods: :days_later,
		}))
	end

	def days_later
		days_difference = (self.expiry.to_date - Date.today).to_i
	
		if days_difference == 0
		  "Today"
	elsif days_difference == 1
		  "Tomorrow"
		elsif days_difference > 1
		  "#{days_difference} days later"
		else
		  "Expired"
		end
	  end
end
