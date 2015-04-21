require 'request_status'

class ConnectRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :request, class_name: 'User'
  belongs_to :user_profile, foreign_key: :request_user_profile_id

  def self.find_by_request_token(request_token)
    self.where(request_token: request_token).first
  end

  def open?
  	self.request_status == RequestStatus::OPEN
  end

  def not_open?
  	self.request_status != RequestStatus::OPEN
  end

  def accept!
  	self.request_status = RequestStatus::ACCEPTED
  end

  def accepted?
  	self.request_status == RequestStatus::ACCEPTED
  end

  def reject!
  	self.request_status = RequestStatus::REJECTED
  end

  def rejected?
  	self.request_status == RequestStatus::REJECTED
  end

  def withdraw!
  	self.request_status = RequestStatus::WITHDRAWN
  end

  def withdrawn?
  	self.request_status == RequestStatus::WITHDRAWN
  end

end
