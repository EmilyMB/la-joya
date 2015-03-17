require "spec_helper"

RSpec.describe GamesController do
  describe "#update" do
    it "redirects to new game path when user guesses correctly" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      uploads = []
      5.times { uploads << create(:upload) }
      session[:word] = uploads.first
      session[:word_list] = uploads

      put :update, { id: uploads.first.id, guess: uploads.first.meaning }

      expect(response).to redirect_to(new_game_path)
      expect(flash[:message]).to be_present
    end

    it "renders the same game when the user guesses incorrectly" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      uploads = []
      5.times { uploads << create(:upload) }
      session[:word] = uploads.first
      session[:word_list] = uploads

      put :update, { id: uploads.first.id, guess: uploads.second.meaning }

      expect(response).to have_http_status(200)
      expect(flash[:alert]).to be_present
    end
  end
end
