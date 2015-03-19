Rails.application.routes.draw do
  get '/profiles/skills.json', to: 'user_profiles#skills', as: :user_profile_skills

  delete '/profiles/destroy', to: 'user_profiles#destroy', as: :destroy_profile

  resources :user_profiles, path: :profiles, only: [:index, :new, :create], as: :profiles
  #resources :user_profiles, path: :profiles, as: :profiles
  

  get '/dashboards', to: 'dashboards#index'

  devise_for :users, controllers: { registrations: :registrations }
  root 'home#index'
end