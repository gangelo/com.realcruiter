class CreateCustomSkills < ActiveRecord::Migration
  def change
    create_table :custom_skills do |t|
      t.string :name
      t.belongs_to :user_profile, index: true

      t.timestamps null: false
    end
    add_foreign_key :custom_skills, :user_profiles
  end
end
