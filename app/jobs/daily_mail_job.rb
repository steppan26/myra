class DailyMailJob < ApplicationJob
  queue_as :default

  def perform
    p "Begin"
    users = User.all.each do |user|
      subs = user.subscriptions.select { |sub| (sub.renewal_date - sub.reminder_delay_days) == Date.today }
      p subs
      if subs.any?
        puts user
        UserMailer.reminder(user).deliver!
      end
      p "----------"
    end
  end
end 