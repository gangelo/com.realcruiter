class AddRequestStatusToConnectRequests < ActiveRecord::Migration
  def change
    add_column :connect_requests, :request_status, :integer, default: 0, null: false
  end
end
