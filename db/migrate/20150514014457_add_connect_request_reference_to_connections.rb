class AddConnectRequestReferenceToConnections < ActiveRecord::Migration
  def change
    add_reference :connections, :connect_request, index: true
    add_foreign_key :connections, :connect_requests
  end
end
