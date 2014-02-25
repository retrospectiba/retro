class AddUserAndProjectToBadsAndGoods < ActiveRecord::Migration
  def up
    add_column :goods, :user_id, :integer
    add_column :bads, :user_id, :integer
  end

  def down
    remove_column :goods, :user_id
    remove_column :bads, :user_id
  end
end
