class AddUserAndProjectToRetro < ActiveRecord::Migration
  def up
    add_column :retrospectives, :project, :string
  end

  def down
    remove_column :retrospectives, :project
  end
end
