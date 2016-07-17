Rails.application.routes.draw do
	resources :friendships
	delete '/logout' => 'sessions#destroy'
	get "/sent_message" => 'users#sent_message'
	resources :sessions, only: [:new , :create]
	root 'home#index'
  	resources :users
  
  	resources :conversations do
  		resources :messages
 	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
