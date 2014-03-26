class ChangeAdminToRole < ActiveRecord::Migration
  def self.up
    rename_column :users, :admin, :role
    change_column :users, :role, :string
  end
end
