class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :connected_user_id
      t.integer :connected_user_profile_id
      t.integer :status, default: 0, null: false

      t.timestamps null: false
    end
  end
end