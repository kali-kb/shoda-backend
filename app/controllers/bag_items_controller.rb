class BagItemsController < ApplicationController

	include AuthHelper
	before_action :authenticate_shopper

	#all bag items should be cleared after an order is placed
	#a bag items can be deleted

	def index
		@bag_items = @shopper.bag_item.includes(:product)
		render :index
	end

	def create
		product_id = bag_item_params[:product_id]
		quantity = bag_item_params[:quantity].to_i
	  
		bag_item = @shopper.bag_item.find_or_initialize_by(product_id: product_id)
		new_record = bag_item.new_record?
	  
		if new_record
		  bag_item.quantity = quantity
		else
		  bag_item.quantity += quantity
		end
	  
		if bag_item.save
		  @bag_item = bag_item
		  @message = new_record ? "Item added" : "Quantity updated"
		  render :show, status: :created
		else
		  render json: bag_item.errors, status: :unprocessable_entity
		end
	end
	  

	def destroy
		logger.info "executing"
		bag_item_id = params[:id]
		bag_item = BagItem.find_by(item_id: bag_item_id)
		bag_item.destroy
		head :no_content
	end

	private

		#create an AuthenticationHelper for commonly used code
		def authenticate_shopper
			id = authenticate_token("shopper")
		    @shopper = Shopper.find_by(shopper_id: id)
		end

		def bag_item_params
			params.require(:bag_item).permit(:quantity, :product_id)
		end

end
