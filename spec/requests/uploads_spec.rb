require 'rails_helper'

describe 'uploads' do
  let(:upload) { create(:upload) }

  context 'logged in user' do
    before { user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user) }

    it 'DELETE /uploads/:id' do
      delete upload_path(upload)
      expect(response.status).to eq 302
    end
  end

  context 'an admin' do
    before { create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user) }

    context 'company not yet created' do
      xit 'GET /v1/companies/:id' do
        get v1_company_path(product.id), {}
        expect(response.status).to eq 200
        expect(response.json['company']['id']).to eq product.id
        expect(response.json['company']['legal_name']).to be_blank
      end

      xit 'PUT /v1/companies/:id' do
        params = {company: {legal_name: 'DesignBook, LLC'}}
        put v1_company_path(product.id), params
        expect(response.status).to eq 200
        expect(response.json['company']['id']).to eq product.id
        expect(response.json['company']['legal_name']).to eq 'DesignBook, LLC'
      end
    end

    context 'pre-existing company' do
      before { Company.create(legal_name: 'foo', product: product) }

      xit 'GET /v1/companies/:id' do
        get v1_company_path(product.id), {}
        expect(response.status).to eq 200
        expect(response.json['company']['id']).to eq product.id
        expect(response.json['company']['legal_name']).to eq 'foo'
      end
    end
  end

  context 'user w/o access' do
    it 'GET /uploads' do
      get uploads_path, {}
      expect(response.status).to eq 302
    end

    it 'POST /uploads' do
      post uploads_path, { audio: file_to_upload }
      expect(response.status).to eq 302
    end

    it 'GET /uploads/new' do
      get new_upload_path, {}
      expect(response.status).to eq 302
    end

    it 'GET /uploads/:id/edit' do
      get edit_upload_path(upload), {}
      expect(response.status).to eq 302
    end

    it 'PUT /uploads/:id' do
      put upload_path(upload), { meaning: "perro" }
      expect(response.status).to eq 302
    end

    it 'DELETE /uploads/:id' do
      delete upload_path(upload)
      expect(response.status).to eq 302
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
