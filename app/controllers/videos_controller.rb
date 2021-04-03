class VideosController < ApplicationController

  def new
    @video = Video.new
  end

  def create
    # obj = S3_BUCKET.objects[params[:video].original_filename]
    # obj.write(
    #   file: params[:file],
    #   acl: :public_read
    # )

    @video = Video.new(video_params)
    @video.user_id = current_user.id

    #binding.pry
    respond_to do |format|
      if @video.save
        
        format.html { redirect_to root_path, notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:file)
    end
end
