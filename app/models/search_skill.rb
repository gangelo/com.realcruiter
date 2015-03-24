class SearchSkill
	attr_accessor :skill_name

	def skill_valid(valid)
		@skill_name = valid
	end

	def skill_valid?
		@skill_name
	end
end