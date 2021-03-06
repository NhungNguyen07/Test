class UserMailer < ApplicationMailer

  def account_activation user
    @user = user
    mail to: user.email, subject: Settings.account_activation
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: Settings.password_reset
  end
end
