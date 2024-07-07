class MerchantsController < ApplicationController
	before_action :set_merchant, only: [:show, :dashboard, :update] #[:show, :edit, :update]

	def create
    	@merchant = Merchant.new(merchant_params)
    	if @merchant.save
    		generate_token
	  		render json: {"merchant": @merchant, token: @token}, status: :created
    	else
      		render json: @merchant.errors, status: :unprocessable_entity
    	end
 	end


	def dashboard
		#create a count of all products created by merchant
		@sales = Order.where(merchant_id: @merchant.merchant_id).sum(:total_amount)

		sales_data = Order
			.where(merchant_id: @merchant.merchant_id)
			.select("DATE_FORMAT(date_created, '%Y-%m') AS month, SUM(total_amount) AS total_sales")
			.group("DATE_FORMAT(date_created, '%Y-%m')")
			.order("month ASC")
		
		# Convert the sales data to the desired format
		chart_data = sales_data.map do |record|
			month_year = record.month.split('-')
			month_name = Date::MONTHNAMES[month_year[1].to_i]
			{
			name: "#{month_name} #{month_year[0]}",
			total_sales: record.total_sales
			}
		end
		  
		@product_count = Product.where(merchant_id: @merchant.merchant_id).count
		render json: {total_products: @product_count, total_sales: @sales, chart_data: chart_data}, status: :ok
	end


	def update
		@merchant = Merchant.find_by(merchant_id: params[:id])
		if @merchant.present?
		  logger.info "merchant data: #{@merchant}"
		  updated_fields = merchant_params.to_h.slice(:first_name, :last_name, :bank_detail)
		  if @merchant.update_columns(updated_fields)
			render json: @merchant, status: :ok
		  else
			render json: @merchant.errors, status: :unprocessable_entity
		  end
		else
		  render json: { error: "Merchant not found" }, status: :not_found
		end
	end

 	def login
	    @merchant = Merchant.find_by(email: merchant_params[:email])
	    if @merchant && @merchant.authenticate(merchant_params[:password])
	      generate_token
	      render json: { message: "Login successful", token: @token }, status: :ok
	    else
	      render json: { errors: ["Invalid email or password"] }, status: :unauthorized
	    end
	end

 	def show
 		render json: @merchant 
 	end

    private
		
		def generate_token
    	  hmac_secret = ENV["HMAC_SECRET"] #reside in .env or some secret file
		  payload = {"merchant_id": @merchant[:merchant_id], "name": "#{@merchant[:first_name]} #{@merchant[:last_name]}"}
		  @token = JWT.encode(payload, hmac_secret, 'HS256')
    	end

	    def set_merchant
	      @merchant = Merchant.find(params[:id])
	    end

	    def merchant_params
	      params.require(:merchant).permit(:first_name, :last_name, :email, :password, :avatar_img_url, :bank_detail)
	    end

end
