require "mail"

Mail.defaults do
  delivery_method :smtp, { :address              => "smtp.gmail.com",
                           :port                 => 587,
                           :domain               => 'your.host.name',
                           :user_name            => 'jacobsolomonow@gmail.com',
                           :password             => 'gusxef-vaqza4-ryvnEj',
                           :authentication       => 'plain',
                           :enable_starttls_auto => true  }
end
