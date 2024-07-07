module OrderCreator

  class OrderCreationService

    def initialize(current_shopper, order_params, logger)
      @shopper = current_shopper
      @customer_data = order_params
      @logger = logger
    end


    def create_orders
      @bag_items = @shopper.bag_item
      if @bag_items.empty?
        return { status: :error, message: "Your bag is empty. Please add products to your bag before creating an order." }
      end

      @orders = []
      @merchants = []
      errors = []
      customer = @shopper.customer
      customer ||= Customer.create(shopper_id: @shopper.id, phone_number: @customer_data[:phone_number], address: @customer_data[:address], city:@customer_data[:city], postal_code: @customer_data[:postal_code])

      @bag_items.each do |bag_item|
        @merchants.push(bag_item.product.merchant_id)
        random_hash = SecureRandom.hex(6)
        order = Order.create(
          merchant_id: bag_item.product.merchant_id,
          order_number: "ord-#{random_hash}",
          customer_id: customer.customer_id, 
          total_items: bag_item.quantity,
          total_amount: bag_item.total_price, 
          status: :unfulfilled
        )

        if order.save!
          @orders << order
          bag_item.product.decrement!(:available_stocks, bag_item.quantity)
          bag_item.product.save!
        else
          errors << order.errors.full_messages.join(", ")
        end
      end

      if errors.empty?
        @shopper.bag_item.destroy_all
        return { status: :success, message: "Order(s) created successfully!", orders: @orders , merchants: @merchants.uniq}
      else
        return { status: :error, message: "Order creation failed: #{errors.join(", ")}" }
      end
    end
  end
end


