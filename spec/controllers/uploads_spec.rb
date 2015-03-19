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
  end

  describe "#create" do
    it "uploads the file" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)

      expect {
        post :create, { audio: file_to_upload }
      }.to change{ Upload.count }.by(1)

      expect(response).to redirect_to(new_upload_path)
      expect(flash[:error]).not_to be_present
    end

    it "doesn't upload a file for an non-authorized user" do
      expect {
        post :create, { audio: file_to_upload }
      }.to change{ Upload.count }.by(0)

      expect(response).to redirect_to(root_path)
    end
  end

  describe "#destroy" do
    it "deletes the upload and redirects to the new upload path" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      post :create, { audio: file_to_upload }

      expect {
        delete :remove_upload, id: Upload.last
      }.to change{ Upload.count }.by(-1)
      expect(response).to redirect_to(new_upload_path)
      expect(flash[:error]).not_to be_present
    end
  end

  describe "#add_meaning" do
    it "adds meaning to the upload" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      post :create, { audio: file_to_upload }

      put :add_meaning, id: Upload.last, meaning: "perro"
      upload = Upload.last

      expect(upload.meaning).to eq("perro")
      expect(upload.meaning_en).to eq("dog")
      expect(response).to redirect_to(new_upload_path)
    end
  end

  def file_to_upload
    ActionDispatch::Http::UploadedFile.new(
      type: "audio/wav",
      head: "Content-Disposition: form-data; name=\"audio\"; "\
        "filename=\"1426362615855.mp3\"\r\nContent-Type: audio/wav\r\n",
      filename: "1426362615855.mp3",
      tempfile: File.new("#{Rails.root}/spec/fixtures/test_clip.wav")
    )
  end
end
