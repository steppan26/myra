class DailyMailJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      subs = user.subscriptions.select { |sub| (sub.renewal_date - sub.reminder_delay_days) == Date.today }
      unless subs.empty?
        UserMailer.with(user: user).reminder
      end
    end
  end
end 