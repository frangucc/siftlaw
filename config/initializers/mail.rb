ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'baci.lindsaar.net',
    :user_name            => 'mytest1221@gmail.com',
    :password             => '11qqaazz',
    :authentication       => 'plain',
    :enable_starttls_auto => true 
  } 
 
ActionMailer::Base.delivery_method = :smtp
