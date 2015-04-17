require 'request_to_connect_creator'

class ConnectionsController < ApplicationController
  before_action :authenticate_user!, except: [:request_show, :request_accept, :request_reject]

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
    if @request_token = request_show_params[:request_token]
        if @user_profile = ConnectRequest.find_by_request_token(@request_token).user_profile
          return
        end
    end

    @user_profile = nil
    flash[:alert] = 'The request could not be found'
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
    params.permit(:request_token)
  end
end
