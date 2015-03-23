class SkillsCreator
  def initialize(user_profile, skill_name)
    @user_profile = user_profile
    @skill_name = skill_name
  end

  def execute(&block)
    skill = first_or_create_skill()
    yield skill if block_given?
    skill
  end

  private

  def first_or_create_skill() 
    Skill.where(skill_where_clause).first || CustomSkill.where(custom_skill_where_clause).first_or_create(custom_skill_params)
  end

  def skill_where_clause
    ["name ILIKE ?", @skill_name]
  end

  def custom_skill_where_clause
    ["name ILIKE ? AND user_profile_id = ?", @skill_name, @user_profile.id]
  end

  def custom_skill_params
    { name: @skill_name, user_profile_id: @user_profile.id }
  end
end