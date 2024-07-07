json.array! @bag_items do |bag_item|
  json.item_id bag_item.item_id
  json.quantity bag_item.quantity
  json.created_at bag_item.created_at
  json.updated_at bag_item.updated_at
  json.product do
    json.product_id bag_item.product.product_id
    json.title bag_item.product.title
    json.price bag_item.product.price
    json.img_url bag_item.product.img_url
  end
end
