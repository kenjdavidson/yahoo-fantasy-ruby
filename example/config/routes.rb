Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'static_pages#index'
  get '/contact', to: 'static_pages#contact'
  get '/privacy', to: 'static_pages#privacy'
  get '/terms', to: 'static_pages#terms'

  # SessionController handles the user/session management from OmniAuth
  # In this particular case, /auth/yahoo is passed through to the session#code
  # which will display a simple form providing the user a link and an input to
  # continue.
  get '/auth/yahoo', to: 'session#oob'
  post '/auth/yahoo/callback', to: 'session#create'
  delete '/auth/logout', to: 'session#destroy'
end
