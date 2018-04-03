class UserMailer < ApplicationMailer

  def account_activation user
    @user = user
    mail to: user.email, subject: Settings.account_activation
  end

  def password_reset
    @greeting = t "hi"
    mail to: Settings.email_com
  end
end
