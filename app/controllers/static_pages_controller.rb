class StaticPagesController < ApplicationController
  before_filter :disable_nav, only: [:landing]
  before_filter :authorize!, except: [:landing]
end
