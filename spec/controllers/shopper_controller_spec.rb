require "rails_helper"

RSpec.describe ShoppersController, type: :controller do

	#account cant be created twice

	describe "POST /auth/shoppers" do
		let(:valid_params) do
			{
				shopper: {
					email: "ethiodevtube@gmail.com",
					password: "kb1234"
				}
			}
		end

		it "creates returns created status even when name isnt provided" do
			post :create, params: valid_params
			expect(response).to have_http_status(:created)
		end

		it "name exists" do
			post :create, params: valid_params
			response_body = JSON.parse(response.body)
			expect(response_body["shopper"]["name"]).to be_present
		end

		it "fails to create when email and password arent present" do
			invalid_params = valid_params.deep_dup
	      	invalid_params[:shopper].delete(:password)
			post :create, params: invalid_params
			expect(response).to have_http_status(:unprocessable_entity)
		end
	end
end