# encoding : utf-8
module UsersHelper

  ROLES = { admin: 'Administrador', team_leader: 'Líder de Time', po: 'PO', user: 'Usuário', ct: 'CT', qa: 'QA', analist: 'Analista' }

  def role_name(role)
    return ROLES[role.to_sym]
  end

  def base_url
    request.base_url
  end
end
