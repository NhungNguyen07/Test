class UserMailer < ApplicationMailer

  def account_activation user
    @user = user
    mail to: user.email, subject: Settings.account_activation
  end

  def password_reset
    @greeting = ""
    mail to: ""
  end
end
