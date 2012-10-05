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
website_urls = ["http://www.yelp.com/search?cflt=lawyers&find_desc=&find_loc=Chicago%2C+IL#!", "http://www.yelp.com/search?find_desc=lawyers&find_loc=San+Diego%2C+CA&ns=1&ls=a2c67ebcec24d9ae", "http://www.yelp.com/search?find_desc=lawyers&find_loc=New+York%2C+NY&ns=1&ls=2b06c8573fc026aa"]
i = 0
website_urls.each do |website_url|
  doc = Nokogiri::HTML.parse(open(website_url, 'User-Agent' => 'ruby'))
  doc.css('.businessresult .media-story h4 a').each do |link|
    details_url = "http://www.yelp.com#{link['href']}"
    puts details_url
    details_content = Nokogiri::HTML.parse(open(details_url, 'User-Agent' => 'ruby'))

    user_name = details_content.css("#bizBox a#user_name")[0].content
    user_mail = "#{user_name.gsub(' ', '_').gsub('.', '')}@siftlaw.com"
    com_name = details_content.css("#bizBox #bizInfoHeader h1")[0].content.gsub("\n",'').gsub("\t",'')
    address = details_content.css("#bizBox #bizInfoContent address span")[0].content
    city = details_content.css("#bizBox #bizInfoContent address span")[1].content
    state = details_content.css("#bizBox #bizInfoContent address span")[2].content
    phone = details_content.css("#bizBox #bizInfoContent #bizPhone")[0].content
    web_url = details_content.css("#bizBox #bizInfoContent #bizUrl")[0]
    website = web_url ? web_url.content.gsub("\n","").gsub("\t", "").gsub(" ", "") : ''
    about_sec = details_content.css("#about_this_biz .section")[0]
    about = about_sec ? about_sec.content : ""
    img_link = details_content.css('#bizBox #bizPhotos .photo-box a')[0] || details_content.css("a#slide-viewer-all")[0]
    img_page = img_link ? "http://www.yelp.com#{img_link["href"]}" : ""
    image_url = ""
    unless img_page.blank?
      begin 
        image_doc = Nokogiri::HTML.parse(open(img_page, 'User-Agent' => 'ruby'))
        image_url = "http:#{image_doc.css('#selected-photo-main img')[0]["src"]}"
      rescue
        puts "... No image"
      end
    end
    primary_category = "Collections"
    cat_links = details_content.css("#bizBox #bizInfoContent #cat_display a")
    cats = cat_links.map{|link| link.content.gsub("\n", "").gsub("\t","")}
    Common.categories.each do |cat|
      if cats.include?(cat) || cats.include?(cat.split(' ').first)
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
      company.about = about
      company.phone = phone
      company.website = website
      company.pro = i < 7 ? true : false 
      company.save!
      puts "   ....and company #{company.name}"
      unless image_url.blank?
        begin
          open("tmp/photo_#{i}.jpg", 'wb') do |file|
            file << open(URI.escape(image_url), 'User-Agent'=>'ruby').read
            company.portfolios.create(image: file)
            puts "  ...created portfolio"
          end
          File.delete("tmp/photo_#{i}.jpg")
          puts "  ...delete temp file"
        rescue Exception => e
          puts e
        end
      end
    end
    i += 1

  end
end
