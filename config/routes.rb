Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: 'mains#index'

  # Registrations
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  # Logout
  delete 'logout', to: 'sessions#destroy'

  # Login
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  # Movies
  
  # Watched
  post "add_watched", to: "movies#add_watched_movie"
  post "remove_watched", to: "movies#remove_watched_movie"
  get "watched", to: "movies#watched"

  # Favorite
  get "favorite", to: "movies#favorite"
  post "add_favorite", to: "movies#add_favorite_movie"
  post "remove_favorite", to: "movies#remove_favorite_movie"

  # To Watch
  get "to_watch", to: "movies#watch_list"
  post "add_to_watch", to: "movies#add_watch_movie"
  post "remove_to_watch", to: "movies#remove_watch_movie"

  # Search
  get 'search', to: 'searchs#search'
  get "show_movie", to: "movies#show" 
end
