class ConnectRequest < ActiveRecord::Base
  WITHDRAWN = -99
  REJECTED = -90
  OPEN = 0
  ACCEPTED = 1

  belongs_to :user
  belongs_to :user_profile, foreign_key: :request_user_profile_id
  has_one :connection

  validates_presence_of :user_id, :request_user_id, :request_user_profile_id, :request_status

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

end
