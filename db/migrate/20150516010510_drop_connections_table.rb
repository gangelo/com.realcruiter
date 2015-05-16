class DropConnectionsTable < ActiveRecord::Migration
  def change
  	drop_table :connections
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
