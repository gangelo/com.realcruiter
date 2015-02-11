class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :type
      t.string :profile_name

      t.timestamps null: false
    end
  end
end
