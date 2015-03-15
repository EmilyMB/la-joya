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
    @upload.update_attributes(new_meaning_params)
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
                         meaning: "no meaning",
                         meaning_en: "no meaning",
                         user_id: current_user.id)
    if @upload.save
      flash[:message] = "File successfully uploaded"
    else
      flash[:error] = "There was an error"
    end
    redirect_to new_upload_path
  end

  def new_meaning_params
    if params[:meaning] != ""
      {
        meaning: params[:meaning],
        meaning_en: Dictionary.find(params[:meaning])
      }
    else
      {
        meaning: "no meaning",
        meaning_en: "no meaning"
      }
    end
  end
end
