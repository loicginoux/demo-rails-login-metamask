Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  root 'sessions#index'
  post 'sign-in' => 'sessions#sign_in', :as => 'sign-in'
  post 'message' => 'sessions#message', :as => 'message'
  post 'sign-out' => 'sessions#sign_out', :as => 'sign-out'

  # Defines the root path route ("/")
  # root "posts#index"
end
