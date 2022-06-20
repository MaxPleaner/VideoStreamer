class TagsController < ApplicationController
	before_action :find_film, only: %i[create remove]
	before_action :find_tag, only: %i[show remove]

	def create
		tag = Tag.find_or_create_by!(name: params[:name])
		FilmTagging.find_or_create_by!(tag: tag, film: @film)
		redirect_to controller: "films", action: "show", id: @film.id
	end

	def show
		@films = @tag.films
	end

	def remove
		FilmTagging.find_by(film: @film, tag: @tag).destroy
		@tag.destroy if @tag.films.none?
		redirect_to controller: "films", action: "show", id: @film.id
	end

	private

	def find_tag
		@tag = Tag.find(params[:id])
	end

	def find_film
		@film = Film.find(params[:film_id])
	end
end
