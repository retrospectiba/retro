class RetrospectiveMailer< ActionMailer::Base
  default :from => 'core@iba.com.br'

  def retrospective_resume(id)
    @retrospective = Retrospective.find(id)
    mail(to: @retrospective.team.users.map(&:email), subject: "Items da retrospectiva: #{@retrospective.name}")
  end
end
