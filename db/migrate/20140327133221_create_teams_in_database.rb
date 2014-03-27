class CreateTeamsInDatabase < ActiveRecord::Migration
  def self.up
    teams = { "Time Bruno" => { "email_owner" => "bruno.nascimento@abril.com.br" },
              "Time Arquitetura" => { "email_owner" => "alexandreo.santos@abril.com.br" },
              "Time Pedro" => { "email_owner" => "bruno.milare@iba.com.br" },
              "Time Ricardo" => { "email_owner" => "sabrina.timbo@abril.com.br" },
              "Time Juliana" => { "email_owner" => "johalf.santos@abril.com.br" },
              "Time Adriano" => { "email_owner" => "antonio.costa@abril.com.br" },
              "Time Iba" => { "email_owner" => "antonio.costa@abril.com.br" },
              "Time N3" => { "email_owner" => "marcelo.silva@abril.com.br" }
    }

    teams.each do |team_name, team_data|
      user = User.where(email: team_data["email_owner"]).first
      if user.present?
        Team.new(name: team_name, user_id: user.id).save
      end
    end
  end
end
