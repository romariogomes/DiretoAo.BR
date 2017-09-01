Rails.application.routes.draw do
  
  get 'sessions/new'

  get '/home' => 'home#index'

  post '/like' => 'acceptances#acceptancesInterceptor'

  root 'home#index'

  get    'sign_in'   => 'sessions#new'
  post   'sign_in'   => 'sessions#create'
  delete 'sign_out'  => 'sessions#destroy'

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
