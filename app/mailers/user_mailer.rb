class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reminder.subject
  #
  def reminder(user)
    @user = user

    mail(to: @user.email, subject: 'Reminder')
  end
end
