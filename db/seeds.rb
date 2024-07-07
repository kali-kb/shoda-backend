# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.


FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(from: 1000, to: 10000) }
    img_url { Faker::Internet.url }
    available_stocks { Faker::Number.between(from: 10, to: 100) }
    # sizes { %w[S M L XL XXL] }
    # merchant_id: 3  
  end
end

product1 = FactoryBot.create(:product, title: 'Skechers Slip-ins: Arch Fit - Fresh Flare', description: 'This is a custom product 1', price: 2000, img_url: 'https://www.skechers.com/dw/image/v2/BDCN_PRD/on/demandware.static/-/Sites-skechers-master/default/dw8f60b8d2/images/large/149568_BKMT.jpg?sw=800', available_stocks: 50, sizes: ['42'], merchant_id: 3)
product2 = FactoryBot.create(:product, title: 'Arch Fit Arcade - Meet Ya There', description: 'This is a custom product 2', price: 3500, img_url: 'https://www.skechers.com/dw/image/v2/BDCN_PRD/on/demandware.static/-/Sites-skechers-master/default/dw399bb5b2/images/large/177190_BLK.jpg?sw=800', available_stocks: 75, sizes: ["43"], merchant_id: 3)
product3 = FactoryBot.create(:product, title: 'FloatZig Symmetros Shoes', description: 'This is a custom product 3', price: 4800, img_url: 'https://www.skechers.com/dw/image/v2/BDCN_PRD/on/demandware.static/-/Sites-skechers-master/default/dw399bb5b2/images/large/177190_BLK.jpg?sw=800', available_stocks: 25, sizes: [41,43], merchant_id: 3)


FactoryBot.define do
  factory :discount do
    rate { 10 }
    expiry { Date.today + 7.days }
    association :product
  end
end




# 3.times do |i|
#     month = i.months.ago
#     6.times do |j|
#       Order.create!(
#         merchant_id: 3,
#         order_number: "ord-#{SecureRandom.hex(6)}",
#         customer_id: 5,
#         total_items: rand(1..10),
#         total_amount: rand(1000..10000),
#         status: Order.statuses.keys.sample,
#         date_created: Faker::Time.between_dates(from: month.beginning_of_month, to: month.end_of_month, period: :day)
#       )
#     end
#   end
