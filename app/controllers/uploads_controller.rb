class UploadsController < ApplicationController
  before_action :authorize!
  before_action :admin_check!, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    if file_valid?
      process_file
    else
      flash[:error] = "No se pudo guardar el clip"
    end
    redirect_to new_upload_path
  end

  def edit
    @upload = Upload.find(params[:id])
  end

  def add_meaning
    @upload = Upload.last
    @upload.update_attributes(new_meaning_params)
    session[:upload_url] = "#update"
    gon.upload_url = session[:upload_url]

    redirect_to new_upload_path
  end

  def update
    @upload = Upload.find(params[:id])
    @upload.update_attributes(upload_params)

    redirect_to dashboard_path
  end

  def index
    @uploads = Upload.with_meaning
  end

  def remove_upload
    Upload.last.delete
    session[:upload_url] = "#destroy"
    gon.upload_url = session[:upload_url]
    redirect_to new_upload_path
  end

  def destroy
    Upload.destroy(params[:id])

    redirect_to dashboard_path
  end

  private

  def file_valid?
    params[:audio]
  end

  def process_file
    obj = S3_BUCKET.objects[params[:audio].original_filename]
    obj.write(file: params[:audio], acl: :public_read)
    upload = Upload.new(url: obj.public_url,
                        name: obj.key,
                        meaning: "no meaning",
                        meaning_en: "no meaning",
                        user_id: current_user.id)

    if upload.save
      flash[:message] = "File successfully uploaded"
      session[:upload_url] = upload.url
      gon.upload_url = session[:upload_url]
    else
      flash[:error] = "There was an error"
    end
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

  def upload_params
    params.require(:upload).permit(:meaning, :meaning_en, :active)
  end
end
