Rails.application.routes.draw do
	delete '/logout' => 'sessions#destroy'
	resources :sessions, only: [:new , :create]
	root 'users#index'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
