require 'faker'

puts "seeding started..."

User.create!(email: 'test@gmail.com', password: 'password', global_budget_cents: 100)

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
  usage_frequency = ['week', 'month', 'year']
  user = User.first
  rand(1..3).times do
    Offer.create!(
      service: service,
      name: Faker::Subscription.plan,
      price_cents: rand(5..35),
      frequency: Offer::PERIODS.sample,
      category: category,
      user: user
    )
  end
end

def calculatePrice(offer)
  case offer.price_cents
  when 'weekly'
    offer.price_cents / 7
  when 'monthly'
    offer.price_cents / 30
  else
    offer.price_cents / 365
  end
end

3.times do
  offer = Offer.all.sample
  user = User.first
  p user
  Subscription.create!(
    offer: offer,
    user_id: user.id,
    additional_info: Faker::Lorem.sentence(word_count: rand(12..28)),
    price_per_day_cents: calculatePrice(offer),
    renewal_date: Faker::Date.between(from: '2021-11-28', to: '2022-08-25'),
    reminder_delay_days: rand(3..7),
    is_active: true,
    url: offer.service.url,
    image_url: offer.service.image_url,
  )
end

puts "seeding done!"
