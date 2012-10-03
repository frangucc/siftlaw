# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#27.times do |i|
#  user = User.find_or_create_by_email("user_#{i}@siftlaw.com")
#  user.name = Faker::Name.name
#  user.password = 'password'
#  user.password_confirmation = 'password'
#  user.save!
#  puts "(#{i}) created user #{user.name} ...."
#  unless user.company
#    company = Company.new(name: Faker::Company.name.split(",").first, primary_category: Common.categories[i%13], budget: Common.budgets[i%5])
#    company.user = user
#    company.city = Faker::Address.city
#    company.state = Faker::Address.us_state
#    company.address = "#{i*43} #{Faker::Address.street_name.split(",").first}"
#    company.about = Faker::Lorem.paragraphs(2)
#    company.phone = Faker::PhoneNumber.phone_number
#    company.pro = i < 7 ? true : false 
#    company.save!
#    puts "   ....and company #{company.name}"
#    company.portfolios.create(image: File.new("#{Rails.root}/app/assets/images/single-pic.jpg"))
#  end
#  
#end

User.find_each(&:destroy)
doc = Nokogiri::HTML.parse(open("http://ilf.isba.org/SearchReq.aspx?parea=ADMIN&county=COOK&zip=&city=+&APPNAME=ISBAWEB&ARGUMENTS=area%2Ccity%2Czip%2Ccounty%2C-A%2Crcount%2CLastnameFirst&PRGNAME=SNA_SEARCH&rcount=20&submit=Submit"))
i = 0
doc.css('form#frmTest td a').each do |link|
  if link['href'].include?('SelectedItem.aspx?')
    details_url = "http://ilf.isba.org/#{link['href']}"
    details_content = Nokogiri::HTML.parse(open(details_url))
    user_name = details_content.css('table#proTab tr')[0].css('td')[0].content
    user_mail = details_content.css('table#proTab tr')[5].css('td a')[0].content.gsub(' ', '')
    com_name = details_content.css('table#proTab tr')[1].css('td')[0].content
    address = details_content.css('table#proTab tr')[2].css('td')[0].children[0].content
    city = details_content.css('table#proTab tr')[2].css('td')[0].children.last.content.split(',').first
    state = details_content.css('table#proTab tr')[2].css('td')[0].children.last.content.split(',').last.split(' ').first
    phone = details_content.css('table#proTab tr')[3].css('td')[0].content.gsub('Phone: ', '')
    website = details_content.css('table#proTab tr')[6].css('td a')[0].content.gsub(' ', '')
    cat_str = details_content.css('table#proTab tr')[15].css('td')[0].content
    primary_category = "Personal Injury"
    Common.categories.each do |cat|
      if cat_str.include?(cat) || cat_str.include?(cat.split(' ').first)
        primary_category = cat
      end
    end

    user = User.find_or_create_by_email(user_mail)
    user.name = user_name
    user.password = 'password'
    user.password_confirmation = 'password'
    user.save!
    puts "(#{i}) created user #{user.name} ...."
      
    unless user.company
      company = Company.new(name: com_name, primary_category: primary_category, budget: Common.budgets[i%5])
      company.user = user
      company.city = city
      company.state = state
      company.address = address
      company.about = cat_str
      company.phone = phone
      company.website = website
      company.pro = i < 7 ? true : false 
      company.save!
      puts "   ....and company #{company.name}"
      company.portfolios.create(image: File.new("#{Rails.root}/app/assets/images/single-pic.jpg"))
    end
    i += 1
  end
end
