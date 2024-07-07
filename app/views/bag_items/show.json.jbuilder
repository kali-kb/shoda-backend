json.extract! @bag_item, :item_id, :quantity, :created_at, :updated_at
json.product do
  json.extract! @bag_item.product, :product_id, :title, :price, :img_url
end
json.message @message
