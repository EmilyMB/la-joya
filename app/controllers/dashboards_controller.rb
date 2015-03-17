class DashboardsController < ApplicationController
  before_action :authorize!
  before_action :admin_check!
  
  def show
    @uploads = Upload.all
  end
end
