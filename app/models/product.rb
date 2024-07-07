class SizesCoder
	def self.load(value)
	  value.nil? ? []: value.split(',')
	end
  
	def self.dump(value)
	  value.join(',')
	end
end

class Product < ApplicationRecord
	serialize :sizes, coder: SizesCoder
	validates :title, length: { minimum: 5 }
	belongs_to :merchant
	has_many :bag_item, dependent: :destroy, foreign_key: :product_id
	has_one :discount, foreign_key: :product_id, dependent: :destroy

	def is_available?
		self.available_stocks > 0
	end

end

