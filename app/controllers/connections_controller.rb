require 'crypted_request_to_connect_token_creator'
require 'request_to_connect_creator'

class ConnectionsController < ApplicationController
  before_action :authenticate_user!, except: [:request_show, :request_connect]

  def create
    if current_user.connect_request_exists?(create_params[:user_id], create_params[:user_profile_id])
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
    request = load_request(request_show_params)
    if request.present? && request.open?
      @request_token = request_show_params[:request_token]
      @connect_request = request
    else
      flash[:alert].now = 'The request is invalid' 
    end
  end

  def request_connect
    request = load_request(request_connect_params)
    unless request.present?
      flash.now[:alert] = 'The request is invalid or could not be found'
      return render :request_show
    end

    interactor = ConnectionCreator.new(request, accept_request?)
    if interactor.execute
      flash[:notice] = "Request #{if interactor.accepted? then 'accepted' else 'rejected' end} successfully"
      redirect_to root_path
    else
      flash.now[:alert] = 'Unable to save request'
      @connect_request = request
      render :request_show
    end
  end

  private

  def load_request(params)
    interactor = CryptedRequestToConnectTokenCreator.new(params[:request_token], :decrypt)
    id = interactor.execute.to_i
    ConnectRequest.find(id)
  rescue
    # TODO: log
    ConnectRequest.none
  end

  def accept_request?
    (request_connect_params[:request_action].presence || 'reject') == 'accept'
  end

  def create_params
    params.permit(:user_id, :user_profile_id)
  end

  def request_show_params
    params.permit(:request_token)
  end

  def request_connect_params
    params.permit(:user_id, :user_profile_id, :request_token, :request_action)
  end
end
