class UserNotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier_mailer.signup_alert.subject
  #
  def signup_alert(user_data)
    @user_name = user_data.first_name
    mail(to: user_data.email, subject: "your account has been created!")
  end

  def forgot_alert(user_data,new_password)
    @user_name = user_data.first_name
    @user_pass = new_password
    mail(to: user_data.email, subject: "your new password has been generated!")
  end

  def reset_alert(user_data)
    @user_name = user_data.first_name
    mail(to: user_data.email, subject: "your reset password has been successful!")
  end

end
