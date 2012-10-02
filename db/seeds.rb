# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

27.times do |i|
  user = User.find_or_create_by_email("user_#{i}@siftlaw.com")
  user.name = Faker::Name.name
  user.password = 'password'
  user.password_confirmation = 'password'
  user.save!
  puts "(#{i}) created user #{user.name} ...."
  unless user.company
    company = Company.new(name: Faker::Company.name.split(",").first, primary_category: Common.categories[i%13], budget: Common.budgets[i%5])
    company.user = user
    company.city = Faker::Address.city
    company.state = Faker::Address.us_state
    company.address = "#{i*43} #{Faker::Address.street_name.split(",").first}"
    company.about = Faker::Lorem.paragraphs(2)
    company.phone = Faker::PhoneNumber.phone_number
    company.pro = i < 7 ? true : false 
    company.save!
    puts "   ....and company #{company.name}"
    company.portfolios.create(image: File.new("#{Rails.root}/app/assets/images/single-pic.jpg"))
  end
  
end
