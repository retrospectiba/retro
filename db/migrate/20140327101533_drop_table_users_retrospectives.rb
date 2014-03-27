class DropTableUsersRetrospectives < ActiveRecord::Migration
  def self.up
    drop_table :users_retrospectives
  end
end
