Rails.application.routes.draw do
  get '/users/dashboard', to: 'dashboard#index', as: :user_dashboard

  devise_for :users, controllers: { registrations: :registrations }
  root 'home#index'
end