ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 587,
	:authentication => 'plain',
	:enable_starttls_auto => true,
	:domain => 'www.1337pic.com',
	:user_name => ENV['GMAIL_USERNAME'],
	:password => ENV['GMAIL_PASSWORD']

}
