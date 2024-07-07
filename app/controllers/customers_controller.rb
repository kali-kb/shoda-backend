class CustomersController < ApplicationController

    include AuthHelper
    before_action :authenticate_merchant


    def index
        @customers = @merchant.customer_with_shoppers.uniq { |customer| customer.customer_id }
        @customers = @customers.map do |customer|
            customer.as_json.merge(shopper: customer.shopper)
        end
        render json: @customers, status: :ok
    end


    # def index
    #     @customers = @merchant.customer_with_shoppers
    #     render json: @customers, status: :ok
    # end


    private

		def authenticate_merchant
			id = authenticate_token("merchant")
            logger.info("id: #{id}")
			@merchant = Merchant.find_by(merchant_id: id)
		end
end
