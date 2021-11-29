# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/reminder
  def reminder
    user = User.last
    UserMailer.with(user: user).reminder
  end

end
