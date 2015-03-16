require "spec_helper"

RSpec.describe SessionsController do
  render_views

  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe "GET index" do
    it "assigns @uploads" do
    end
  end
end
