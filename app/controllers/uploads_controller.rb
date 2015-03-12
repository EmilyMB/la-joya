class UploadsController < ApplicationController
  before_action :authorize!
  skip_before_action :verify_authenticity_token

  def new
    @upload = Upload.last
  end

  def create
    if file_valid?
      process_file
    else
      flash[:error] = "No se pudo guardar el clip"
      redirect_to new_upload_path
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

  def destroy
    Upload.last.delete
    redirect_to new_upload_path
  end

  private

  def file_valid?
    params[:audio]
  end

  def process_file
    obj = S3_BUCKET.objects[params[:audio].original_filename]
    obj.write(file: params[:audio], acl: :public_read)
    @upload = Upload.new(url: obj.public_url,
                         name: obj.key,
                         meaning: "no meaning")
    if @upload.save
      flash[:success] = "File successfully uploaded"
    else
      flash[:error] = "There was an error"
    end
    redirect_to new_upload_path
  end
end
