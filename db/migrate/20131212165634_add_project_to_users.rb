class AddProjectToUsers < ActiveRecord::Migration
  def up
    add_column :users, :project, :string, :null => false
  end

  def down
    remove_column :users, :project
  end
end
