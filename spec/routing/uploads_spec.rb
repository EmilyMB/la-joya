require "spec_helper"

describe "the uploads" do
  include Capybara::DSL

  context "user not logged in" do
    it "visits uploads_path" do
      visit uploads_path

      expect(current_path).to eq(root_path)
    end

    it "visits new_upload_path" do
      visit new_upload_path

      expect(current_path).to eq(root_path)
    end

    it "visits edit_upload_path" do
      upload = create(:upload)

      visit edit_upload_path(id: upload.id)

      expect(current_path).to eq(root_path)
    end
  end

  context "user logged in" do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)
    end

    it "visits dashboard_path" do
      visit dashboard_path

      expect(current_path).to eq(root_path)
    end

    it "visits new_upload_path" do
      visit new_upload_path

      expect(current_path).to eq(new_upload_path)
    end

    it "visits edit_upload_path" do
      upload = create(:upload)

      visit edit_upload_path(id: upload.id)

      expect(current_path).to eq(root_path)
    end
  end

  context "admin logged in" do
    before(:each) do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(admin)
    end

    it "visits dashboard_path" do
      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
    end

    it "visits new_upload_path" do
      visit new_upload_path

      expect(current_path).to eq(new_upload_path)
    end

    it "visits edit_upload_path" do
      upload = create(:upload)

      visit edit_upload_path(upload)

      expect(current_path).to eq(edit_upload_path(upload))
    end
  end
end
