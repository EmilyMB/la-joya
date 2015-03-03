class UploadsController < ApplicationController
  before_action :authorize!

  def new
  end

  def create
    if file_present?
      process_file
    else
      flash.now[:error] = "Elegir un archivo para subir"
      render :new
    end
  end

  def index
    @uploads = Upload.all
  end

  private

  def file_present?
    params[:file]
  end

  def process_file
    obj = S3_BUCKET.objects[params[:file].original_filename]
    obj.write(file: params[:file], acl: :public_read)
    @upload = Upload.new(url: obj.public_url, name: obj.key, meaning: params[:meaning])
    if @upload.save
      redirect_to uploads_path, success: "File successfully uploaded"
    else
      flash.now[:error] = "There was an error"
      render :new
    end
  end
end
