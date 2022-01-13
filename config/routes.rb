Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/dashboard', to: 'users#show'
  get '/edit', to: 'users#edit'
  patch '/update', to: 'users#update'
  delete '/logout', to: 'sessions#destroy'


  resources :letters, only: [:show, :new, :create]
end
