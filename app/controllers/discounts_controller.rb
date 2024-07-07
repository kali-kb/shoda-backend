class DiscountsController < ApplicationController
	include AuthHelper

	before_action :authenticate_merchant

	def create
	  discount_params = params.require(:discount).permit(:rate, :expiry, :product_id)
	  discount = Discount.new(discount_params)
	  discount.merchant_id = @merchant.merchant_id 

	  if discount.save
	    render json: discount, status: :created
	  else
	    render json: discount.errors, status: :unprocessable_entity
	  end
	end


	def index
		@discounts = @merchant.discount
		render :index
	end

	# def index
		# discounts = @merchant.discount
		
		# discount.each |discount| do
		# 	discount["shopper"] = Product.find_by(product_id: discount.product_id)
		# end
		# render json: discounts.as_json(include: :product), status: :ok
	# end

	def bulk_delete
		discount_ids = params.require(:discount_ids)
		discounts = Discount.where(discount_id: discount_ids)
		discounts.destroy_all
		head :no_content
	end


	def destroy
		discount = Discount.find_by(discount_id: params[:discount_id])
		if discount
			discount.destroy
			head :no_content
		else
			render json: { message: "Discount not found" }, status: :not_found
		end
	end


	private

		def authenticate_merchant
			id = authenticate_token("merchant")
			@merchant = Merchant.find_by(merchant_id: id)
		end
end
