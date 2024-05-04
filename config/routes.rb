# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :orders
    
    resources :products do
      resources :stocks
    end
    resources :categories
    # root to: "admin#index"
  end
  resources :members

  # get 'members/index'
  # get 'members/create'
  # get 'members/new'
  # get 'members/edit'
  # get 'members/update'
  # get 'members/destroy'
  resources :companies
  devise_for :users # , :controllers => {:registrations => "users/registrations"}
  resources :friends
  
  get 'home/index', as: :home
  get 'home/about'
  get "admin" => "admin#index"
  get "cashier" => "cashier#index"
  get "manager" => "manager#index"
  get "cart"  => "carts#show"
  # get "category" => "category#index"
  resources :categories, only: [:show]
  resources :products, only: [:show]
  # resources :cashier do
  #   get :index, to: 'cashier#index'  # cashier_index_path
  # end

  # resources :manager do
  #   get :index, to: 'manager#index'  # manager_index_path
  # end
  devise_scope :user do
    root to: 'home#index'
    get 'devise/registrations/new', as: :sign_up
  end

  # namespace :admin do
  #   root to: "admin#index"
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "home#index"
  # root "friends#index"

  # authenticated :user do
  #   root to: "admin#index", as: :admin_root
  # end

end
