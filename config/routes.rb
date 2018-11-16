Rails.application.routes.draw do
  get 'portfolios/new'
	#devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign-up'}, controllers: { registrations: 'users/registrations' }
	devise_for :users, skip: [:registrations, :sessions]
	as :user do
		get 'sign_up', to: 'users/registrations#new'
		post 'sign_up', to: 'users/registrations#create'
		get 'sign_in', to: 'devise/sessions#new'
		post 'sign_in', to: 'devise/sessions#create'
		delete 'sign_out', to: 'users/sessions#destroy'
	end
	get 'my_portfolios', to: 'users#show'
	resources :portfolios, only: [:new, :create, :destroy, :show, :index]
	root to: 'portfolios#index'
end
