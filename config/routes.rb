Rails.application.routes.draw do
  
  devise_for :admins, controllers: {
  sessions: 'admin/sessions'
}
devise_for :customers, controllers: {
  sessions: 'customer/sessions',
  registrations: 'customer/registrations'
}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get  'admin' => 'admin/home#top'
  namespace :admin do
  	resources :items, only:[:new, :create, :index, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :order_items, only: [:update]
	end
  get  'items' => 'customer/items#index', as: "customer_items"
  get  'items/:id' => 'customer/items#show', as: "customer_item"
  get 'cart_items' => 'customer/cart_items#index', as: "cart_items"
  post 'cart_items' => 'customer/cart_items#create'
  patch 'cart_items/:id' => 'customer/cart_items#update',as: "cart_item"
  delete 'cart_items/:id' => 'customer/cart_items#destroy', as: "destroy_cart_item"
  delete 'cart_items' => 'customer/cart_items#destroy_all', as: "destroy_cart_items"

  get "admin/orders" => "admin/orders#index", as: "admin_orders"
  get "admin/orders/:id" => "admin/orders#show", as: "admin_order"
  patch "admin/orders/:id" => "admin/orders#update"
  get '/search' => 'search#search'

  get "orders/new" => "customer/orders#new"
  get "orders/confirm" => "customer/orders#confirm"
  post "orders/confirm" => "customer/orders#create"
  get "thanks" => "customer/orders#thanks"
  get "orders" => "customer/orders#index", as: "customer_orders"
  get "orders/:id" => "customer/orders#show", as: "customer_order"
  get "about" => "customer/home#about"
  patch "customers/:id/quit" => "customer/customers#invalid", as: "invalid_customer"

  scope module: 'customer' do
      root 'home#top'
      resources :customers, only:[:show, :edit, :update] do
        member do
          get 'quit'
        end
      end
    resources :'mailing_addresses', only:[:index, :create, :edit, :update, :destroy]
  end
end
  