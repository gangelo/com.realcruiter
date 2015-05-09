class RemoveRequestTokenFromConnectRequests < ActiveRecord::Migration
  def change
    remove_column :connect_requests, :request_token, :string
  end
end
