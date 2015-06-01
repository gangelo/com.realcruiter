class DashboardsController < ApplicationController
  before_action :authenticate_user! 
  
  def index
  	@all_connect_requests = current_user.all_connect_requests
  end
end
