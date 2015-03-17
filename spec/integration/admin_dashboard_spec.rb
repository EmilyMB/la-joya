require "spec_helper"

describe "an admin", type: :feature do
  describe "after logging in" do
    include Capybara::DSL

    it "can visit the admin dashboard" do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(admin)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
    end

    it "can see all the uploads" do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(admin)
      uploads = []
      10.times do
        uploads << create(:upload)
        uploads << create(:upload_without_meaning)
      end

      visit dashboard_path

      expect(page).to have_css("tr.word", count: 20)
    end

    it "can see details for each upload" do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(admin)
      uploads = []
      10.times do
        uploads << create(:upload)
        uploads << create(:upload_without_meaning)
      end

      visit dashboard_path

      uploads.each do |upload|
        expect(page).to have_content(upload.user_id)
        expect(page).to have_content(upload.meaning_en)
        expect(page).to have_content(upload.formatted_created_at)
        expect(page).to have_content(upload.formatted_updated_at)
      end
    end

    it "can see a button to activate and edit each upload" do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(admin)
      uploads = []
      10.times do
        uploads << create(:upload)
        uploads << create(:upload_without_meaning)
      end

      visit dashboard_path

      expect(page).to have_link("Activar", count: 20)
      expect(page).to have_link("Editar", count: 20)
    end

    it "can click a button and be taken to the edit upload page" do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(admin)
      uploads = []
      10.times do
        uploads << create(:upload)
        uploads << create(:upload_without_meaning)
      end

      visit dashboard_path
      first(:link, "Editar").click

      expect(current_path).to eq(edit_upload_path(uploads.first))
    end

    it "can activate an upload" do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(admin)
      upload = create(:upload)

      visit dashboard_path
      first(:link, "Activar").click

      expect(current_path).to eq(dashboard_path)
      expect(Upload.find(upload.id).active?).to be_truthy
    end
  end
end
