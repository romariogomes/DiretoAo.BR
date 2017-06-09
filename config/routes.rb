Rails.application.routes.draw do
  
  get '/home' => 'home#index'

  root 'home#index'

  resources :comments
  resources :acceptances
  resources :interactions
  resources :notices
  resources :experiences
  resources :states
  resources :charges
  resources :politicians
  resources :law_projects
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
