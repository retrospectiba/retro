class RemoveUserIdFromRetro < ActiveRecord::Migration
  def self.up
    remove_column :retrospectives, :user_id
  end
end
