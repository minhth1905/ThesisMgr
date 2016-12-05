Devise.setup do |config|
  config.authentication_keys = [:login]
  config.scoped_views = true
  config.mailer_sender = "demosachmem@gmail.com"
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.secret_key = '7f0536aab8be9dfcbb7852d21e0eafc4a6f0d9a156406dd9f2f7b0dff413b24ac8bc17be5b6b6ea745d5f7310e88d84c29e22aade772e5a942576e21275743a6'
end
