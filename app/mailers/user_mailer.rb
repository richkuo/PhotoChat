class UserMailer < ActionMailer::Base
  default from: "admin@1337pic.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "1337Pic Password Reset"
  end

  def signup_notification(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to 1337Pic!"
  end

end
