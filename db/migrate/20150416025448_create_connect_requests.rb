class CreateConnectRequests < ActiveRecord::Migration
  def change
    create_table :connect_requests do |t|
      t.integer :user_id
      t.integer :request_user_id
      t.integer :request_user_profile_id

      t.timestamps null: false
    end
  end
end
