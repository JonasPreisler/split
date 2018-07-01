Rails.application.routes.draw do
  resources :orders
  devise_for :users
  resources :businesses
  resources :customers
  root to: "orders#index"
  namespace 'api' do
    namespace 'v1' do
      resources :orders
  	end
  end
end