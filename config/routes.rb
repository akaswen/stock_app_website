Rails.application.routes.draw do
  #devise_for :users, controllers: { registrations: 'users/registrations' }
	devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign-up'}, controllers: { registrations: 'users/registrations' }
	resources :users, only: [:show]	
	root to: 'users#show'
end
