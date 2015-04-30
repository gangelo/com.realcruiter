class Connection < ActiveRecord::Base
  WITHDRAWN = -99
  ACTIVE = 1

  before_create :activate!
  
  belongs_to :user

  validates_presence_of :user_id, :connected_user_id, :connected_user_profile_id, :status

  def activate!
    self.status = ACTIVE
  end

  def active?
    self.status == ACTIVE
  end

  def not_active?
    self.status != ACTIVE
  end

  def withdraw!
    self.status = WITHDRAWN
  end

  def withdrawn?
    self.status == WITHDRAWN
  end
end
