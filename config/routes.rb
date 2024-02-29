Rails.application.routes.draw do
  resources :members
  # get 'members/index'
  # get 'members/create'
  # get 'members/new'
  # get 'members/edit'
  # get 'members/update'
  # get 'members/destroy'
  get 'members/profile', to: 'members#profile', as: :members_profile
  resources :companies
  devise_for :users#, :controllers => {:registrations => "users/registrations"}
  resources :friends
 get 'home/index'
 get 'home/about'
 devise_scope :user do
  root to: "devise/registrations#new"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  
  #root "home#index"
   #root "friends#index"
end
