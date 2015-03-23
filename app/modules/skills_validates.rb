module Skills
  module Validates
    def self.included(base)
      base.validates_presence_of :name
    end
  end
end