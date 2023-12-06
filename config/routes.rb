Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }


  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :routes do
    resources :bookings, only: [:new, :create]
    resources :destinations, except: [:destroy]
    get 'details', to: 'routes#details'
  end

  resources :bookings, only: [:show, :index, :show, :update, :destroy]

  # put "/routes/:id/favorite", to: "routes#favorite", as: "favorite"
  resources :favorites, only: [:index, :create, :destroy]


  # Defines the root path route ("/")
  # root "posts#index"
end
