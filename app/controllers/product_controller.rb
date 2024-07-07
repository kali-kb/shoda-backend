class ProductController < ApplicationController

  include AuthHelper
  before_action :authenticate_shopper, only: [:index, :show]


  def index
	logger.info "query: #{params[:query]}"
	@products = if params[:query].present?
				  Product.includes(:discount).where("title LIKE ?", "%#{params[:query]}%")
				else
				  Product.includes(:discount).all
				end
	render json: @products, only: [:product_id, :available_stocks, :sizes, :title, :img_url, :price], include: { discount: { only: [:rate, :expiry] } }
  end
  

#   def index
# 	logger.info "query: #{params[:query]}"
#   	@products = if params[:query].present?
#                 Product.where("title LIKE ?", "%#{params[:query]}%")
#               else
#                 Product.all
#               end
#   	render json: @products, only: [:product_id, :available_stocks, :title, :img_url, :price]
#   end


	#for products created by one merchant
  def merchant_products
	@product = Product.where(merchant_id: params[:merchant_id])
	render json: @product, status: :ok
  end

  def create
    @product = Product.new(product_params)
    @product.merchant_id = params[:merchant_id]
    if @product.save
      render json: {"message": "Product created successfully"}, status: :created
    else
      render json: {errors: @product.errors}, status: :unprocessable_entity
    end
  end

  def show
  	@product = Product.find_by(params[:product_id])
  	render json: @product, status: :ok
  end

  #catch errors effectively
  def destroy
  	id = params[:product_id]
  	@product = Product.find_by!(product_id:id)
  	if @product
	  	@product.destroy
	  	head :no_content
  	else
  		render json: {errors: @product.errors}, status: :unprocessable_entity
  	end
  end

  def destroy_multiple
	product_ids = params[:product_ids]
	logger.info "product_ids: #{product_ids}"
	@products = Product.where(product_id: product_ids)
	if @products.destroy_all
		head :no_content
	else
		render json: { errors: "Failed to delete products" }, status: :unprocessable_entity
	end
  end
  

  #update only selected keys
  def update
	  id = params[:product_id]
	  @product = Product.find_by!(product_id: id)
	  @product.update(product_params)
	  if @product.errors.empty?
	    render json: { message: "Product updated successfully" }, status: :ok
	  else
	    render json: { errors: @product.errors }, status: :unprocessable_entity
	  end
  end

  
  private

  	def authenticate_shopper
		id = authenticate_token("shopper")
		@shopper = Shopper.find_by(shopper_id: id)
		logger.info(@shopper)
	end

	def product_params
		params.require(:product).permit(:title, :description, :price, :img_url, :available_stocks, :created_at, :updated_at, :sizes => [])
	end
end
