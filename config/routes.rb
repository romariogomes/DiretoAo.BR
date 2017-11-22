Rails.application.routes.draw do
  
  resources :parties
  get 'sessions/new'

  get '/home' => 'home#index'
  
  get '/ranking' => 'ranking#index'
  get '/curtidas' => 'ranking#loadGraphic'
  get '/espectro' => 'users#politicSpectre'
  get 'ranking/data', :defaults => { :format => 'json' }

  post '/like' => 'acceptances#acceptancesInterceptor'
  post '/update-comment' => 'comments#updateComment'

  post '/generate-colors' => 'ranking#generateColorsToSequencesGraph'

  root 'home#index'

  get    'sign_in'   => 'sessions#new'
  post   'sign_in'   => 'sessions#create'
  delete 'sign_out'  => 'sessions#destroy'

  get 'projeto' => 'home#o_projeto'
  get 'projeto/esquerda-direita' => 'home#esquerda_direita'
  get 'projeto/espectro-politico' => 'home#espectro_politico'

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
