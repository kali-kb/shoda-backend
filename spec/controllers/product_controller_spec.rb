require "rails_helper"

RSpec.describe ProductController, type: :controller do


  describe "GET /products" do
    it "returns a success status when sent token in header" do
      request.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzaG9wcGVyX2lkIjoxLCJuYW1lIjpudWxsfQ.XM00DFLWnIGEePhXldiP4-pJrHPDDYD6ZohaB6NuhTQ"
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "returns unauthorized when not sent any token" do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /product/:product_id" do
    it "returns success status code when token is sent" do
      let(:product_id) { 6 }
      get(:shop)
      request.header["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzaG9wcGVyX2lkIjoxLCJuYW1lIjpudWxsfQ.XM00DFLWnIGEePhXldiP4-pJrHPDDYD6ZohaB6NuhTQ"
      expect(request).to have_http_status(:ok)
    end

    it "returns unauthorized status code when token is not sent" do
      let(:product_id) { 6 }
      get(:shop)
      expect(request).to have_http_status(:unauthorized)
    end
  end
  
  describe "POST merchants/:merchant_id/products" do
    let(:valid_params) do
      {
        merchant_id: 1,
        product: {
          title: "Nikeee",
          description: "Test Description",
          price: 1350,
          img_url: "https://example.com/image.jpg",
          sizes: ["S", "M", "L"],
          # available_stocks: { "S" => 10, "M" => 20, "L" => 15 }
          # sizes: "S, M",
          available_stocks: 34,
        },
      }
    end

    it "creates a new product and returns created status" do
      post :create, params: valid_params
      expect(response).to have_http_status(:created)
    end

    it "returns unprocessable entity when the product isn't saved successfully" do
      # Invalid parameters, missing required fields
      invalid_params = valid_params.except(:title)
      post :create, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end