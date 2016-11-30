Devise.setup do |config|
  config.mailer_sender = 'host: "localhost", port: 3000'
  config.scoped_views = true
  config.password_length = 6..20
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..20
  config.email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
