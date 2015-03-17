require "spec_helper"

RSpec.describe GamesController do
  render_views

  describe "GET index" do
    it "assigns @uploads" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).
        and_return(user)
      upload = create(:upload)
      get :index

      expect(assigns(:uploads)).to eq([upload])
    end
