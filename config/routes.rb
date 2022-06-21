Rails.application.routes.draw do
  root "films#index"

  get "films/recommendation", to: "films#new_recommendation", as: :film_recommendation
  post "films/recommendation", to: "films#submit_recommendation", as: :submit_film_recommendation
  get '/recommendations', to: "films#show_recommendations", as: :recommendations
  post '/recommendation/:id/destroy', to: "films#destroy_recommendation", as: :destroy_recommendation
  
  resources :films, except: [:new, :create]
  resources :unsynced_films, only: [:index, :show]


  get "films/:id/watch", to: "films#watch", as: :watch_film

  # should be a post, but too lazy to convert link to form
  get '/unsynced_films/:id/match', to: "unsynced_films#match_unsynced_film", as: :match_unsynced_film

  resources :tags, only: %i[create show]
  post 'tags/:id/remove', to: 'tags#remove', as: :remove_tag

  resources :comments, only: %i[create]
  post 'comments/:id/remove', to: "comments#remove", as: :remove_comment

  get 'info', to: "application#info", as: :info
end
