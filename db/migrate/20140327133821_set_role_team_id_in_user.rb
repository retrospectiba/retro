class SetRoleTeamIdInUser < ActiveRecord::Migration
  def self.up
    users = { "antonio.costa@abril.com.br" => { "role" => "admin", "team" => "Time Arquitetura" },
              "arnaldo.junior@abril.com.br" => { "role" => "ct", "team" => "Time Ricardo" },
              "barbara.velludo@abril.com.br" => { "role" => "analist", "team" => "Time Juliana" },
              "bruno.milare@iba.com.br" => { "role" => "team_leader", "team" => "Time Pedro" },
              "bruno.nascimento@abril.com.br" => { "role" => "po", "team" => "Time Bruno" },
              "cleber.silva_cwi@abril.com.br" => { "role" => "qa", "team" => "Time Ricardo" },
              "daniel.simon@iba.com.br" => { "role" => "team_leader", "team" => "Time Arquitetura" },
              "danilo.lima@abril.com.br" => { "role" => "admin", "team" => "Time Arquitetura" },
              "eduardo.schneiders@cwi.com.br" => { "role" => "user", "team" => "Time Bruno" },
              "Oswaldo.funfas@iba.com.br" => { "role" => "user", "team" => "Time Juliana" },
              "gabrielsobreira@cwi.com.br" => { "role" => "qa", "team" => "Time Bruno" },
              "jairton.cordeiro@iba.com.br" => { "role" => "ct", "team" => "Time Arquitetura" },
              "alexandreo.santos@abril.com.br" => { "role" => "admin", "team" => "Time Arquitetura" },
              "joao.britto@plataformatec.com.br" => { "role" => "user", "team" => "Time Adriano" },
              "johalf.santos@abril.com.br" => { "role" => "team_leader", "team" => "Time Juliana" },
              "johnvoloski@cwi.com.br" => { "role" => "user", "team" => "Time Arquitetura" },
              "juliana.vital@iba.com.br" => { "role" => "po", "team" => "Time Juliana" },
              "lucas.prieto@iba.com.br" => { "role" => "user", "team" => "Time Ricardo" },
              "lucasweiblen@cwi.com.br" => { "role" => "user", "team" => "Time Pedro" },
              "luis.barrionuevo@abril.com.br" => { "role" => "ct", "team" => "Time Arquitetura" },
              "marcelo.silva@abril.com.br" => { "role" => "user", "team" => "Time N3" },
              "phoenix@iba.com.br" => { "role" => "team_leader", "team" => "Time Pedro" },
              "rafael.rossi@abril.com.br" => { "role" => "user", "team" => "Time Arquitetura" },
              "raphael.oliveira@abril.com.br" => { "role" => "user", "team" => "Time Arquitetura" },
              "roberto.carlos@iba.com.br" => { "role" => "team_leader", "team" => "Time Bruno" },
              "sabrina.timbo@abril.com.br" => { "role" => "team_leader", "team" => "Time Ricardo" },
              "thais.campos@abril.com.br" => { "role" => "user", "team" => "Time Bruno" }
    }

    users.each do |user_email, user_data|
      user = User.where(email: user_email).first
      team = Team.where(name: user_data['team']).first
      if team.present?
        user.role = user_data['role']
        user.team_id = team.id
        user.save
      end
    end

    User.where(team_id: 0).each do |user|
      team = Team.where(name: "Time Arquitetura").first
      user.role = "user"
      user.team_id = team.id
      user.save
    end
  end
end
