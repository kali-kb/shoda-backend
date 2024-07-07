Rails.application.routes.draw do
  resources :bag_items
  resources :merchants do
    member do
      get 'dashboard'
    end
    resources :products, param: :product_id, controller: "product", except: [:index, :show]
    resources :discounts
    resources :orders, only: [:index, :update, :destroy], param: :order_id
    resources :notifications, only: [:index]
  end
  post "/orders", to: "orders#create"
  put "/merchants/:merchant_id", to: "merchants#update"
  get "merchants/:merchant_id/customers", to: "customers#index"
  get "merchants/:merchant_id/products", to: "product#merchant_products"
  delete "/merchants/:merchant_id/products", to: "product#destroy_multiple"
  delete "/merchants/:merchant_id/discounts", to: "discounts#bulk_delete"
  put "/merchants/:merchant_id/notifications", to: "notifications#update"

  put "/merchants/:merchant_id/orders", to: "orders#bulk_update"

  get "/products", to: "product#index"
  get "/products/:product_id", to: "product#show"
  get "/checkout", to: "orders#order_checkout" 

  # scope path: "/products", controller: :shoppers do
  #   get "/", to: "product#index"
  #   get "/:product_id", to: "product#show"
  # end
  
  scope path: "/auth/shoppers", controller: :shoppers do
    post "/" => :create
    post "/login" => :login
  end

  scope path: "auth/merchants", controller: :merchants do
    post "/" => :create
    post "/login" => :login
  end



  get "up" => "rails/health#show", as: :rails_health_check

  get '/ping', to: -> (env) { [200, {}, ['Hello, world!']] }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
end
