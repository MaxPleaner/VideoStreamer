class TagsController < ApplicationController
	before_action :find_film, only: %i[create]
	before_action :find_tag, only: %i[show]

	def create
		tag = Tag.find_or_create_by!(name: params[:name])
		FilmTagging.find_or_create_by!(tag: tag, film: @film)
		redirect_to controller: "films", action: "edit", id: @film.id
	end

	def show
		@films = @tag.films
	end

	private

	def find_tag
		@tag = Tag.find(params[:id])
	end

	def find_film
		@film = Film.find(params[:film_id])
	end
end
