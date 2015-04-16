require 'request_to_connect_creator'

class ConnectionsController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.connect_request_already_exists?(create_params[:user_id], create_params[:user_profile_id])
      redirect_to :back, alert: "You've already sent a request to this user"
    else
      interactor = RequestToConnectCreator.new(current_user, create_params)
      if interactor.execute
        redirect_to dashboards_path, notice: 'Your request to connect has been sent!'
      else
        redirect_to :back, alert: 'There was a problem sending your request'
      end
    end
  end

  def request_show
    uuid = request_show_params[:uuid]
  end

  def request_accept
  end

  def request_reject
  end

  private

  def create_params
    params.permit(:user_id, :user_profile_id)
  end

  def request_show_params
    params.permit(:token)
  end
end
