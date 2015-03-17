require "spec_helper"

describe "dashboard page" do
  include Capybara::DSL

  context "user not logged in" do
    it "visits dashboard_path" do
      visit dashboard_path

      expect(current_path).to eq(root_path)
    end
  end

  context "user logged in" do
    it "visits dashboard_path" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(current_path).to eq(root_path)
    end
  end

  context "admin logged in" do
    it "visits dashboard_path" do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(admin)

      visit dashboard_path

      expect(current_path).to eq(dashboard_path)
    end
  end
end
