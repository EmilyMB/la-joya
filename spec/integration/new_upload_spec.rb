require "spec_helper"

describe "a new upload", type: :feature do
  describe "updating a meaning" do
    include Capybara::DSL

    it "starts with no meaning" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      upload = create(:upload)

      visit new_upload_path(upload)

      click_link_or_button("Grabar")
    end
  end
end
