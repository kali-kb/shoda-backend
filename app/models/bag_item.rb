class BagItem < ApplicationRecord
	belongs_to :shopper
	belongs_to :product, primary_key: :product_id
	# has_one :associated_product, through: :product, source: :product

	def total_price
	  if self.product.discount.present?
	    rate = self.product.discount.rate
	    original_price = self.product.price
	    new_price = original_price - (original_price * (rate.to_f / 100))  # Use rate.to_f for division
	    total_amount = new_price * self.quantity
	    total_amount.to_i
	  else
	    self.product.price * self.quantity
	  end
	end

end
