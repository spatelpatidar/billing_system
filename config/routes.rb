Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
  root "products#index"
  get "/orders/search", to: "orders#search", as: :search_orders
  get "/orders/customer", to: "orders#customer_orders", as: :customer_orders

  resources :products#, only: [:index]
  resources :orders, only: %i[new create show]
  resources :denominations, only: [:destroy]

end
