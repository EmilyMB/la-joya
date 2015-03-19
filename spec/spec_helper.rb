require "capybara/rspec"
require "rails_helper"
require "factory_girl_rails"
require "factory_girl"
require "support/factory_girl"
require "simplecov"
require "rack_session_access/capybara"

SimpleCov.start "rails"

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  :provider => 'facebook',
  :uid => '123545',
  :info => {
    :email => "bob",
    :name => "bob",
    :first_name => "bob",
    :profile_image_url => "bob.com"
  },
  :credentials => {
    :token => "111"
  }
})

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include Rails.application.routes.url_helpers

  config.color = true

  config.tty = true
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
end
