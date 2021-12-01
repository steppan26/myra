class UpdateRenewalJob < ApplicationJob
  queue_as :default

  def perform
    subs = Subscription.all
    subs.each do |sub|
      if sub.renewal_date == Date.today
        case sub.offer.frequency
        when "weekly"
          sub.renewal_date += 7
        when "monthly"
          sub.renewal_date += 1.months
        else
          sub.renewal_date += 1.years
        end
        sub.save!
      end
    end
  end
end