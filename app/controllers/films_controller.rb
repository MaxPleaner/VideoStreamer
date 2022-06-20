class FilmsController < ApplicationController
  before_action :set_film, only: %i[ show edit update destroy watch]

  # GET /films or /films.json
  def index
    @films = Film.all
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.create(film_params)
    redirect_to @film
  end

  def watch
    @files = @film.get_media_files
    @vids = @files[:video]
    if params[:selected_video].present?
      selected_video = JSON.parse(params[:selected_video])
      @selected_video = {
        media_type: selected_video["media_type"],
        file: @vids.values.flatten.find { |vid| vid.name == selected_video["name"] }
      }
    end
    @subs = @files[:subtitle]
  end

  # GET /films/1 or /films/1.json
  def show
    @files = @film.get_media_files
  end

  # GET /films/1/edit
  def edit
  end

  # PATCH/PUT /films/1 or /films/1.json
  def update
    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to film_url(@film), notice: "Film was successfully updated." }
        format.json { render :show, status: :ok, location: @film }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1 or /films/1.json
  def destroy
    @film.destroy

    respond_to do |format|
      format.html { redirect_to films_url, notice: "Film was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film
      @film = Film.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def film_params
      params.require(:film).permit(:name, :director, :year, :description)
    end
end
