class AddForgotPasswordTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forgot_password_token, :string
  end
end
