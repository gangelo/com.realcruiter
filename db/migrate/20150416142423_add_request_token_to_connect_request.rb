class AddRequestTokenToConnectRequest < ActiveRecord::Migration
  def change
    add_column :connect_requests, :request_token, :string
  end
end
