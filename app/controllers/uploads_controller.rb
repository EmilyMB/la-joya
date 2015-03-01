class UploadsController < ApplicationController
  def new
  end

  def create
    obj = S3_BUCKET.objects[params[:file].original_filename]
    obj.write(file: params[:file], acl: :public_read)
    @upload = Upload.new(url: obj.public_url, name: obj.key, meaning: params[:meaning])
    if @upload.save
      redirect_to uploads_path, success: "File successfully uploaded"
    else
      flash.now[:notice] = "There was an error"
      render :new
    end
  end

  def index
    @uploads = Upload.all
  end
end
