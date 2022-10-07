Rails.application.routes.draw do
  root "films#index"
  get "/films", to: "films#index"

  scope "films" do
    get "video_file", to: "films#video_file", as: :film_video_file

    get "films/subtitle_file", to: "films#subtitle_file", as: :film_subtitle_file
    get "films/recommendation", to: "films#new_recommendation", as: :film_recommendation
    post "films/recommendation", to: "films#submit_recommendation", as: :submit_film_recommendation
    get '/recommendations', to: "films#show_recommendations", as: :recommendations
    post '/recommendation/:id/destroy', to: "films#destroy_recommendation", as: :destroy_recommendation

    get "films/upload", to: "films#upload", as: :upload_film
    post "films/chunk_create", to: "films#chunk_create", as: :chunk_create

    resources :films, except: [:new, :create]
    resources :unsynced_films, only: [:index]

    # This is done outside of resources because the :id passed here is actually a string
    # And it can cause issues when part of the URL
    get '/unsynced_film', to: "unsynced_films#show", as: :unsynced_film
    post '/force_create_unsynced_film', to: "unsynced_films#force_create", as: :force_create_film

    get "films/:id/watch", to: "films#watch", as: :watch_film

    # should be a post, but too lazy to convert link to form
    get '/unsynced_films/match', to: "unsynced_films#match_unsynced_film", as: :match_unsynced_film

    resources :tags, only: %i[create show]
    post 'tags/:id/remove', to: 'tags#remove', as: :remove_tag

    resources :comments, only: %i[create]
    post 'comments/:id/remove', to: "comments#remove", as: :remove_comment

    get 'info', to: "application#info", as: :info
  end
end
