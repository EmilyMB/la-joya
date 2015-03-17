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

    it "can details for each upload" do
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
        expect(page).to have_content(upload.created_at)
        expect(page).to have_content(upload.updated_at)
      end
    end

  end
end
