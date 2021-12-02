require 'faker'
require 'csv'

filepath = 'db/services.csv'
csv_options = { col_sep: ',', quote_char: '"' }

puts "seeding started..."

#User.create!(email: 'test@gmail.com', password: 'password', global_budget_cents: 10_000)

def calculatePrice(frequency ,offer_value, multiplied)
  if multiplied
    case frequency
    when 'weekly'
      return offer_value * 7
    when 'monthly'
      return offer_value * 30
    else
      return offer_value * 365
    end
  else
    case frequency
    when 'weekly'
      return offer_value / 7
    when 'monthly'
      return offer_value / 30
    else
      return offer_value / 365
    end
  end
end

Service.destroy_all
Category.destroy_all
Offer.destroy_all

CSV.foreach(filepath, csv_options) do |row|
  unless Service.find_by(name: row[0])
    Service.create!(
      name: row[0],
      url: row[1],
      image_url: row[7]
    )
  end
end

puts "services done"

Category.create!(name: "Streaming")
Category.create!(name: "Fitness")
Category.create!(name: "Gaming")
Category.create!(name: "Communication")
Category.create!(name: "Food & Drink")
Category.create!(name: "eCommerce")
Category.create!(name: "Books & News")
Category.create!(name: "Personal Care & Health")
Category.create!(name: "Pet Care")
Category.create!(name: "Software")
Category.create!(name: "Academy")
Category.create!(name: "Transportation")
Category.create!(name: "None")

CSV.foreach(filepath, csv_options) do |row|
  Offer.create!(
    service: Service.find_by(name: row[0]),
    name: row[2],
    price_cents: (row[3].to_f * 100).to_i,
    frequency: row[4],
    category: Category.where(name: row[5]).first,
    service_name: row[0]
  )
end

# 3.times do
#   offer = Offer.all.sample
#   user = User.first
#   Subscription.create!(
#     offer: offer,
#     user_id: user.id,
#     additional_info: "One of the best services out there",
#     price_per_day_cents: calculatePrice(offer.frequency, offer.price_cents, false),
#     renewal_date: Faker::Date.between(from: '2021-11-29', to: '2022-01-14'),
#     reminder_delay_days: rand(3..7),
#     is_active: true,
#     url: offer.service.url,
#     image_url: offer.service.image_url
#   )
# end
puts "seeding done!"
