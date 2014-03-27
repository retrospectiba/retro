class SetDefaultValueToRole < ActiveRecord::Migration
  def self.up
    change_column :users, :role, :string, :default => "user"
  end
end
