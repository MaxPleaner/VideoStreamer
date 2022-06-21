class CommentsController < ApplicationController
  before_action :admin_only, only: %i[remove]

  def create
    film = Film.find_by(id: params[:film_id])
    comment = Comment.create!(comment_params)
    redirect_to controller: "films", action: "show", id: film.id
  end

  def remove
    comment = Comment.find(params[:id])
    film = comment.film 
    comment.destroy!
    redirect_to controller: "films", action: "edit", id: film.id
  end

  private

  def comment_params
    params.permit(:author, :content, :film_id)
  end
end
