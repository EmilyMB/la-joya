require "spec_helper"

describe "landing page" do
  include Capybara::DSL

  context "user not logged in" do
    it "visits root_path" do
      visit root_path
      expect(current_path).to eq root_path
    end
  end
end

describe "home page" do
  include Capybara::DSL

  context "user not logged in" do
    it "visits home_path" do
      visit home_path
      expect(current_path).to eq root_path
    end
  end

  context "user logged in" do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)
    end

    it "visits home_path" do
      visit home_path
      expect(current_path).to eq home_path
    end
  end
end

describe "uploads pages" do
  include Capybara::DSL

  context "user not logged in" do
    it "visits uploads_path" do
      visit uploads_path
      expect(current_path).to eq root_path
    end

    it "visits new_upload_path" do
      visit new_upload_path
      expect(current_path).to eq root_path
    end
  end

  context "user logged in" do
    before(:each) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)
    end

    it "visits new_upload_path" do
      visit new_upload_path
      expect(current_path).to eq new_upload_path
    end
  end
end
