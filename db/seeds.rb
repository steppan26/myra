require 'faker'
require 'csv'

filepath = 'db/services.csv'
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }

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

CSV.foreach(filepath, csv_options) do |row|
  unless Service.find_by(name: row[0])
    Service.create!(
      name: row[0],
      url: row[1],
      image_url: row[7]
    )
  end
end

Category.create!(name: "Streaming")
Category.create!(name: "Communication")
Category.create!(name: "Food and drink")
Category.create!(name: "Fitness")
Category.create!(name: "Personal care / Health")
Category.create!(name: "Software")
Category.create!(name: "Transport")
Category.create!(name: "Pet care")
Category.create!(name: "Gaming")
Category.create!(name: "eCommerce")
Category.create!(name: "Books/Magazines/Newspaper")
Category.create!(name: "Academy")


CSV.foreach(filepath, csv_options) do |row|
p row
  Offer.create!(
    service: Service.find_by(name: row[0]),
    name: row[2],
    price_cents: row[3].to_f * 100,
    frequency: row[5],
    category: Category.find_by(name: row[6])
  )
end
puts "seeding done!"
