module TeamsHelper
  def team_leader_name(team)
    User.where(id: team.user_id).first.try(:name)
  end
end
