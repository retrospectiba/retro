class ChangeProjectToTeamIdInRetrospective < ActiveRecord::Migration
  def self.up
    rename_column :retrospectives, :project, :team_id
    change_column :retrospectives, :team_id, :integer
  end
end
