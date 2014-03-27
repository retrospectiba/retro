class SetTeamIdInRetro < ActiveRecord::Migration
  def self.up
    team_iba = Team.where(name: "Time Iba").first
    team_readers = Team.where(name: "Time Pedro").first

    Retrospective.where("name LIKE ?", "%Sprint%").each do |retro|
      retro.team_id = team_iba.id
      retro.save
    end

    Retrospective.where("name LIKE ?", "%PHOENIX%").each do |retro|
      retro.team_id = team_readers.id
      retro.save
    end
  end
end
