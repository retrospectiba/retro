# encoding: utf-8
class RememberPasswordController < ApplicationController
  def index
  end

  def remember_password
    user = User.find_by_email(params[:email])

    if user
      if user.forgot_password_token.blank?
        begin
          user.generate_forgot_password_token
          user.save
          UserMailer.remember_password(user).deliver
          flash[:alert] = "Mensagem enviada com sucesso."
        rescue
          flash[:notice] = 'Um erro ocorreu! Abra um chamado aê, leke!'
        end
      end
    else
      flash[:notice] = "Não foi possível enviar o e-mail para lembrete de senha."
    end

    redirect_to root_path
  end

end
