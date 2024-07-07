class OrdersController < ApplicationController
	
	include AuthHelper
	include OrderCreator
	include PaymentCreator

	before_action :authenticate_shopper, only: [:order_checkout, :create]
	after_action :notify, only: [:create]

	def bulk_update
		order_ids = params[:order_ids]
		orders = Order.where(order_id: order_ids)
		orders.update_all(status: :fulfilled)
		head :ok
	end

	def order_checkout
	 	total_amount = BagItem.where(shopper_id: @shopper.shopper_id).sum(&:total_price)
		logger.info "total_amount: #{total_amount}"
		payment_service = PaymentCreatorService.new(total_amount.to_s, "ETB")
		# payment_service = PaymentCreatorService.new("10", "ETB")
		response = payment_service.initiate_payment
		logger.info response
		render json: response, status: :ok
	end


	def create
	    order_service = OrderCreationService.new(@shopper, order_params, Rails.logger)
	    response = order_service.create_orders
		if response[:status] == :success
		    @merchant_id_list = response[:merchants]
			render json: response, status: :created
		else
		    render json: { errors: response[:message] }, status: :unprocessable_entity
		end
	end	

	def destroy
		@order = Order.find_by(order_id:params[:order_id])
		@order.destroy
		head :no_content
	end

	def index
		@orders = Order.where(merchant_id: params[:merchant_id])
		render json: @orders, status: :ok
	end

	def update
	    @order = Order.find(params[:id])

	    if @order.update(order_params)
	      render json: @order, status: :ok
	    else
	      render json: @order.errors.full_messages, status: :unprocessable_entity
	    end
	end

	private
		def authenticate_shopper
			id = authenticate_token("shopper")
			@shopper = Shopper.find_by(shopper_id: id)
		end

		def notify
		  @merchant_id_list.each do |merchant_id|
		    Notification.create!(message: "An order has been created", merchant_id: merchant_id)
		  rescue ActiveRecord::RecordInvalid => e
		    logger.error "Error creating notifications: #{e.message}"
		  end
		end


		def order_params
			params.require(:order).permit(:phone_number, :address, :city, :postal_code)
		end
end
