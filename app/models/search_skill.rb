class SearchSkill
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Conversion
  
  attr_reader :skill_name

  def skill_name=(value)
    @skill_name = value.titleize
  end

  def skill_valid=(valid)
    @skill_valid = valid
  end

  def skill_valid
    @skill_valid
  end

  def attributes
    { 'skill_name' => @skill_name, 'skill_valid?' => @skill_valid }
  end

  def persisted?
    false
  end
 
  def id
    nil
  end
end