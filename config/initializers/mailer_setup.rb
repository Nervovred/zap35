ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.yandex.ru",  
  :port                 => 25,  
  :user_name            => ENV['MAILER_USER'],  
  :password             => ENV['MAILER_PASSWORD'],  
  :authentication 			=> :login
} 