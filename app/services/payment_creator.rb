require "httpx"

module PaymentCreator
  class PaymentCreatorService

    attr_reader :amount, :currency, :payment_initiation_endpoint, :chapa_private_key_test

    def initialize(amount, currency)
      @amount = amount
      @currency = currency
      @payment_initiation_endpoint = "https://api.chapa.co/v1/transaction/initialize"
      @chapa_private_key_test = ENV["CHAPA_PRIVATE_KEY_TEST"]
    end


    def initiate_payment
    	headers = {"Content-Type": "application/json", "authorization": "Bearer #{@chapa_private_key_test}"}
      random_hash = SecureRandom.hex(16)
    	http = HTTPX.with(headers: headers)
        payment_data = {
          amount: @amount,
          tx_ref: "shodatest-#{random_hash}",
          currency: @currency,
          return_url: "http://172.22.97.242:3000/shopper/processing-order"
        }
	    begin
        response = http.post(@payment_initiation_endpoint, json: payment_data)
        parsed_response = parse_response(response)
        if parsed_response["status"] == "success"
          parse_response(response)
        else
          error_message = parse_response(response)["message"]
          return {message: error_message}
        end
      rescue StandardError => e
        Rails.logger.error "Error initiating Chapa payment: #{e.message}"
        raise 
      end
    end



    def parse_response(response)
      JSON.parse(response.to_s)
    end

    def payment_verify
      # Webhook logic to handle payment success events from Chapa API
    end
  end
end