class AddTargetToRetro < ActiveRecord::Migration
  def change
    add_column :retrospectives, :target, :string
  end
end
