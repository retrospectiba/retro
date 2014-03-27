module TeamsHelper
  def team_leader_name(team)
    return User.where(id: team.user_id).first.name
  end
end
