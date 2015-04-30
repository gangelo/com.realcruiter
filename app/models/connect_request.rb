require 'connection_creator'

class ConnectRequest < ActiveRecord::Base
  WITHDRAWN = -99
  REJECTED = -90
  OPEN = 0
  ACCEPTED = 1

  before_save :create_connection, if: :create_connection?

  belongs_to :user
  belongs_to :user_profile, foreign_key: :request_user_profile_id

  validates_presence_of :user_id, :request_user_id, :request_user_profile_id, :request_token, :request_status

  def self.find_by_request_token(request_token)
    self.where(request_token: request_token).first
  end

  def open?
  	self.request_status == OPEN
  end

  def accept!
  	self.request_status = ACCEPTED
  end

  def accepted?
  	self.request_status == ACCEPTED
  end

  def reject!
  	self.request_status = REJECTED
  end

  def rejected?
  	self.request_status == REJECTED
  end

  def withdraw!
  	self.request_status = WITHDRAWN
  end

  def withdrawn?
  	self.request_status == WITHDRAWN
  end

  private

  def create_connection?
    self.request_status_changed? && self.accepted?
  end

  def create_connection
    interactor = ConnectionCreator.new(self.user, self.attributes)
    interactor.execute
  end

end
