class UserMailer< ActionMailer::Base
  default :from => 'core@iba.com.br'

  def remember_password(user)
    @user = user
    @url = root_url
    mail(to: "#{@user.email}", subject: "Reset de senha")
  end
end
