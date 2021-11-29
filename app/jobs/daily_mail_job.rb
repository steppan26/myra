class DailyMailJob < ApplicationJob
  queue_as :default

  def perform
    p "Begin"
    users = User.all.each do |user|
      subs = user.subscriptions.select { |sub| (sub.renewal_date - sub.reminder_delay_days) == Date.today }
      p subs
      if subs.any?
        puts user
        mail = UserMailer.with(user: user).reminder
        p "mail created"
        mail.deliver_now!
        p "mail delivered"
      end
      p "----------"
    end
  end
end 