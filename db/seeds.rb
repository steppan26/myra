require 'faker'

puts "seeding started..."

User.create!(email: 'test@gmail.com', password: 'password', global_budget_cents: 10_000)

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

Offer.destroy_all
Service.destroy_all
Category.destroy_all

20.times do
  Service.create!(
    name: Faker::Company.name,
    url: Faker::Internet.url,
    image_url: Faker::Company.logo
  )
end

Category.create!(name: "streaming")
Category.create!(name: "communication")
Category.create!(name: "food and drink")
Category.create!(name: "fitness")
Category.create!(name: "personal care / health")
Category.create!(name: "Software")
Category.create!(name: "transport")
Category.create!(name: "pet care")
Category.create!(name: "gaming")
Category.create!(name: "ecommerce")
Category.create!(name: "books/magazines/newspaper")
Category.create!(name: "academy")

Service.all.each do |service|
  category = Category.all.sample
  user = User.first
  frequency = Offer::PERIODS.sample
  rand(1..3).times do
    Offer.create!(
      service: service,
      name: Faker::Subscription.plan,
      price_cents: calculatePrice(frequency, rand(5..35), true),
      frequency: frequency,
      category: category,
      user: user
    )
  end
end

3.times do
  offer = Offer.all.sample
  user = User.first
  Subscription.create!(
    offer: offer,
    user_id: user.id,
    additional_info: Faker::Lorem.sentence(word_count: rand(12..28)),
    price_per_day_cents: calculatePrice(offer.frequency ,offer.price_cents, false),
    renewal_date: Faker::Date.between(from: '2021-11-28', to: '2022-08-25'),
    reminder_delay_days: rand(3..7),
    is_active: true,
    url: offer.service.url,
    image_url: offer.service.image_url
  )
end

puts "seeding done!"
