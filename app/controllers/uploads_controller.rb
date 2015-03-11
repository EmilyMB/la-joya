class UploadsController < ApplicationController
  before_action :authorize!
  skip_before_action :verify_authenticity_token

  def new
    @upload = Upload.last
  end

  def create
    if file_present?
      process_file
    else
      flash.now[:error] = "Elegir un archivo para subir"
      render :new
    end
  end

  def update
    @upload = Upload.last
    @upload.update_attributes(meaning: params[:meaning])
    redirect_to new_upload_path
  end

  def index
    @uploads = Upload.with_meaning
  end

  def stuff
    obj = S3_BUCKET.objects[params[:audio].original_filename]
    obj.write(file: params[:audio], acl: :public_read)
    @upload = Upload.new(url: obj.public_url, name: obj.key, meaning: "no meaning")
    if @upload.save
      flash.now[:success] = "File successfully uploaded"
    else
      flash.now[:error] = "There was an error"
    end
    redirect_to new_upload_path
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
