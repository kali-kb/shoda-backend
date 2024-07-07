class ShoppersController < ApplicationController
	
	def create
		email = shopper_params[:email]
		@shopper = Shopper.new(shopper_params)
		if shopper_params[:name].blank?
			@shopper.name = email.split('@').first
		end
		if @shopper.save
		  generate_token
  		  ShopperWelcomeMailer.welcome_email(@shopper).deliver_later
	      render json: {"shopper": @shopper, "token": @token}, status: :created
	    else
	      render json: @shopper.errors, status: :unprocessable_entity
	    end
    end

    def login
		logger.info("shopper data #{shopper_params[:email]}")
		email_param = shopper_params[:email]
		password_param = shopper_params[:password]
		
		begin
		  @shopper = Shopper.find_by!(email: email_param)
		  if @shopper.authenticate(password_param)
			logger.info("authenticated successfully")
			generate_token
			render json: { token: @token }, status: :ok
		  else
			logger.info("authentication error: invalid password")
			render json: { errors: ["Invalid email or password"] }, status: :unauthorized
		  end
		rescue ActiveRecord::RecordNotFound => e
		  logger.info("authentication error: email not found")
		  render json: { errors: ["Invalid email or password"] }, status: :unauthorized
		end
	end
	
    private

    	def generate_token
    	  hmac_secret = ENV["HMAC_SECRET"] #reside in .env or some secret file
		  payload = {"shopper_id": @shopper[:shopper_id], "name": @shopper[:name]}
		  @token = JWT.encode(payload, hmac_secret, 'HS256')
    	end
	    

	    def shopper_params
	      params.require(:shopper).permit(:name, :email, :password)
	    end

end
