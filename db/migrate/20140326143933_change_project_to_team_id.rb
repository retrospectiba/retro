class ChangeProjectToTeamId < ActiveRecord::Migration
  def self.up
    rename_column :users, :project, :team_id
    change_column :users, :team_id, :integer
  end
end
