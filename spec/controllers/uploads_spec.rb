require "spec_helper"

RSpec.describe UploadsController do
  render_views

  describe "GET index" do
    it "assigns @uploads" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      upload = create(:upload)
      get :index

      expect(assigns(:uploads)).to eq([upload])
    end

    it "renders the index template" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      subject { get :index }
    end

    it "uploads the file" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)

      get :create, params: { audio: file_to_upload }
      expect(response).to redirect_to(new_upload_path)
    end

    def file_to_upload
      ActionDispatch::Http::UploadedFile.new(
        content_type: "audio/wav",
        headers:
        "Content-Disposition: form-data; name=\"audio\"; "\
          "filename=\"1426362615855.mp3\"\r\nContent-Type: audio/wav\r\n",
        original_filename: "1426362615855.mp3",
        tempfile: File.new("#{Rails.root}/spec/fixtures/test_clip.wav")
      )
    end
  end
end
