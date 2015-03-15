require "spec_helper"

describe "a new game", type: :feature do
  describe "visiting the new game page" do
    include Capybara::DSL

    it "has the link to the answer word's sound clip" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      8.times { create(:upload) }

      visit new_game_path

      expect(page.find("#game-clip")["src"]).
        to have_content(page.get_rack_session["word"]["url"])
    end

    it "shows four options" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      8.times { create(:upload) }

      visit new_game_path

      expect(page).to have_css("ul.choices li", count: 4)
    end
  end
end
