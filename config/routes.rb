Rails.application.routes.draw do
  #
  # Connections
  post  'connections/create'
  get   'connections/request', to: 'connections#request_show' 
  get   'connections/accept', to: 'connections#request_accept'
  post  'connections/reject', to: 'connections#request_reject'

  # 
  # User Profile
  get '/profiles/skills.json', to: 'user_profiles#skills', as: :user_profile_skills
  resources :user_profiles, path: :profiles, as: :profiles
  
  # 
  # Dashboard
  get '/dashboards', to: 'dashboards#index'

  #
  # Search
  get '/search', to: 'search#index'
  get '/search/search', to: 'search#search'
  get '/search/skills.json', to: 'search#skills', as: :search_skills
  get '/search/search_profile_skills', to: 'search#search_profile_skills', as: :search_profile_skills

  #
  # Users
  devise_for :users, controllers: { registrations: :registrations }

  #
  # Root
  root 'home#index'
end