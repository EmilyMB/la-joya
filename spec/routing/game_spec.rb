require "spec_helper"

describe "new game page" do
  include Capybara::DSL

  context "user not logged in" do
    it "visits new_game_path" do
      visit new_game_path

      expect(current_path).to eq(root_path)
    end
  end

  context "user logged in" do
    it "visits new_game_path" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)

      visit new_game_path

      expect(current_path).to eq(new_game_path)
    end
  end

  context "admin logged in" do
    it "visits dashboard_path" do
      admin = create(:user, admin: true)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(admin)

      visit new_game_path

      expect(current_path).to eq(new_game_path)
    end
  end
end
