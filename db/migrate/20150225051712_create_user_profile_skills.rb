class CreateUserProfileSkills < ActiveRecord::Migration
  def change
    create_table :user_profile_skills do |t|
      t.belongs_to :user_profile
      t.belongs_to :skill

      t.timestamps null: false
    end
  end
end
