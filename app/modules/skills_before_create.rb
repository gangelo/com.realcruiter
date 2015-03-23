module Skills
  module BeforeCreate
    def self.included(base)
      base.before_create :titleize_name
    end

    private

    def titleize_name
      self.name = self.name.titleize unless self.name.empty?
    end
  end
end