json.array! @discounts do |discount|
  json.extract! discount, :discount_id, :rate, :expiry, :days_later
  json.product do
    json.extract! discount.product, :product_id, :title, :price
  end
end