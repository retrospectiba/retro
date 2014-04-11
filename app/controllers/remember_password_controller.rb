# encoding: utf-8
class RememberPasswordController < ApplicationController
  def index
  end

  def remember_password
    user = User.find(params[:email])

    if user
      if user.forgot_password_token.blank?
        #gera token
        response = user.links.generate_forgot_password_token
        #envia email
      end
      flash[:message] = "Instruções enviadas para o email informado."
    else
      flash[:error] = "Não foi possível enviar o e-mail para lembrete de senha."
    end

    redirect_to root_path
  end

end
