Rails.application.routes.draw do
  resources :films
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "application#index"
  resources :films, except: [:new, :create]
  resources :unsynced_films, only: [:index, :show]

  get "films/:id/watch", to: "films#watch", as: :watch_film

  # should be a post, but too lazy to convert link to form
  get '/unsynced_films/:id/match', to: "unsynced_films#match_unsynced_film", as: :match_unsynced_film

  resources :tags, only: %i[create show]
end
