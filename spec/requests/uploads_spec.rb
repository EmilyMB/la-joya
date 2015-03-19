require "rails_helper"

describe "uploads" do
  let(:upload) { create(:upload) }

  context "logged in user" do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
    end

    it "DELETE /uploads/:id" do
      upload = create(:upload)
      delete upload_path(upload)

      expect(Upload.count).to eq(1)
      expect(response.status).to eq 302
    end
  end

  context "an admin" do
    before (:each) do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(admin)
    end

    it "DELETE /uploads/:id" do
      delete "/uploads/#{upload.id}"

      expect(response.status).to eq 302
      expect(Upload.count).to eq(0)
      expect(response).not_to be_success
    end
  end

  context "user w/o access" do
    it "GET /uploads" do
      get uploads_path, {}
      expect(response.status).to eq 302
    end

    it "POST /uploads" do
      post uploads_path, audio: file_to_upload
      expect(response.status).to eq 302
    end

    it "GET /uploads/new" do
      get new_upload_path, {}
      expect(response.status).to eq 302
    end

    it "GET /uploads/:id/edit" do
      get edit_upload_path(upload), {}
      expect(response.status).to eq 302
    end

    it "PUT /uploads/:id" do
      put upload_path(upload), meaning: "perro"
      expect(response.status).to eq 302
    end

    it "DELETE /uploads/:id" do
      delete upload_path(upload)

      expect(response.status).to eq 302
      expect(Upload.count).to eq(1)
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
