class StaticPagesController < ApplicationController
  before_filter :disable_nav, only: [:home]
end
