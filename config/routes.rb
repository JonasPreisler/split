Rails.application.routes.draw do
  root to: 'pages#landing'
  get '/landing', to: 'pages#landing'
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :property_images
    resources :properties
    resources :orders
    resources :slots
    devise_for :users
    resources :users, only: [:show], :shallow => true do
      resources :properties
    end
    resources :businesses
    resources :leads
    root to: "leads#index"
    get '/nyeleads', to: 'leads#nyeleads'
    get '/:id/tid', to: 'leads#edit'
  end

  namespace 'api', defaults: { format: :json } do
    resources :users
    #scope "/:id", :as => "user" do
    #  resources :properties
    #end
    resources :leads
    resources :properties
    get '/:messenger_user_id/tid', to: 'leads#broadcast'
    #get '/:user', to: 'properties#show'
  end
  mount Split::Dashboard, at: 'split'
end
