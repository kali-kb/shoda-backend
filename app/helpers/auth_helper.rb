module AuthHelper

  def authenticate_token(user_type)
    auth_header = request.headers['Authorization']
    # return nil unless auth_header && auth_header.start_with?('Bearer ')
    return render json: { error: "Authorization header missing or invalid" }, status: :unauthorized unless auth_header && auth_header.start_with?('Bearer ')

    token = auth_header.split(' ').second
    hmac_secret = ENV["HMAC_SECRET"]
    logger.info(hmac_secret)
    begin
      decoded_token = JWT.decode(token, hmac_secret, true, algorithm: 'HS256') #{merchant_id, name: ..}
      user_id_key = user_type == "merchant" ? "merchant_id" : "shopper_id"  # Conditional for user id key
	  @id = decoded_token[0][user_id_key]
    rescue JWT::DecodeError => e
      return render json: { error: "Invalid authentication token" }, status: :unauthorized
    end

    @id
  end

end
