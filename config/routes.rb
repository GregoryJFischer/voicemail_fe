Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create_oauth'
  get '/auth/failure', to: 'sessions#failure'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create_local'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  get '/edit', to: 'users#edit'
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  patch '/update', to: 'users#update'

  get '/fetch_preview', to: 'letters#preview', as: 'fetch_preview'
  
  get '/letters/confirmation', to: "letters#confirmation"
  get '/letters/confirmation.:body', to: "letters#confirmation"
  resources :letters, only: %i[new create]
  post 'checkout/create', to: "checkout#create"

  resources :webhooks, only: [:create]
end
