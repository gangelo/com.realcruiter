Rails.application.routes.draw do
  get '/profiles/skills.json', to: 'user_profiles#skills', as: :user_profile_skills

  resources :user_profiles, path: :profiles, as: :profiles
  
  get '/dashboards', to: 'dashboards#index'

  get '/search', to: 'search#index'
  get '/search/search', to: 'search#search'
  get '/search/skills.json', to: 'search#skills', as: :search_skills

  devise_for :users, controllers: { registrations: :registrations }
  root 'home#index'
end