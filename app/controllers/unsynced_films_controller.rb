class UnsyncedFilmsController < ApplicationController
  before_action :admin_only

  def index
    @film_names = Film.unsynced_film_names
  end

  def show
  	@folder_name = params[:id]
  	@query_name = params[:query_name]
  	@query_name = @folder_name if @query_name.blank?
  	@results = MovieDb.lookup(@query_name)
  end

  def match_unsynced_film
  	@folder_name = params[:id]
  	@query_name = params[:query_name]
  	@match_idx = params[:match_idx]
  	result = MovieDb.lookup(@query_name)[@match_idx.to_i]
  	film = Film.create_from_movie_db_lookup(@folder_name, result)
  	redirect_to film
  end

  def force_create
    film = Film.create!(name: params[:name])
    redirect_to film
  end
end
