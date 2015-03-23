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
    ProcessUpload.new(params[:audio], current_user.id).call
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
