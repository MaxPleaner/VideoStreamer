class DownloadRequestsController < ApplicationController
  before_action :set_download_request, only: %i[ show edit update destroy ]
  before_action :admin_only

  # GET /download_requests or /download_requests.json
  def index
    @download_requests = DownloadRequest.all
  end

  # GET /download_requests/1 or /download_requests/1.json
  def show
  end

  # GET /download_requests/new
  def new
    @download_request = DownloadRequest.new
  end

  # GET /download_requests/1/edit
  def edit
  end

  # POST /download_requests or /download_requests.json
  def create
    @download_request = DownloadRequest.new(download_request_params)

    respond_to do |format|
      if @download_request.save
        format.html { redirect_to download_request_url(@download_request), notice: "Download request was successfully created." }
        format.json { render :show, status: :created, location: @download_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @download_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /download_requests/1 or /download_requests/1.json
  def update
    respond_to do |format|
      if @download_request.update(download_request_params)
        format.html { redirect_to download_request_url(@download_request), notice: "Download request was successfully updated." }
        format.json { render :show, status: :ok, location: @download_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @download_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /download_requests/1 or /download_requests/1.json
  def destroy
    @download_request.destroy

    respond_to do |format|
      format.html { redirect_to download_requests_url, notice: "Download request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_download_request
      @download_request = DownloadRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def download_request_params
      params.require(:download_request).permit(:name, :url, :status)
    end
end
