Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'static_pages#index'
  get 'contact', to: 'static_pages#contact'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'

  # OmniAuth/OAuth2 handles logging in.  To kick this off you must provide a link to
  # the POST /auth/yahoo_oauth to kick off the functionality.
  get 'auth/failure', to: 'session#auth_failure'
  get 'auth/yahoo', to: 'static_pages#index'
  post 'auth/yahoo', to: 'session#out_of_bounds'
  post 'auth/yahoo/callback', to: 'session#create'
  delete 'auth/logout', to: 'session#destroy'

  # User/Profile routes
  get 'profile/edit'
  get 'profile/update', to: redirect('profile/edit')
  post 'profile/update'
  delete 'profile/destroy'
end
