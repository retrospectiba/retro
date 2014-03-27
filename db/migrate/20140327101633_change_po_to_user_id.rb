class ChangePoToUserId < ActiveRecord::Migration
  def self.up
    rename_column :teams, :po_name, :user_id
    change_column :teams, :user_id, :integer
  end
end
