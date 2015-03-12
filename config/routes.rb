Rails.application.routes.draw do
  #get 'user_profiles/create'

  resources :user_profiles, path: :profiles, only: [:new, :create], as: :profiles

  get '/dashboards', to: 'dashboards#index'

  devise_for :users, controllers: { registrations: :registrations }
  root 'home#index'
end