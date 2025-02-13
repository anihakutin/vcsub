Rails.application.configure do
  config.active_storage.service_urls_expire_in = 1.week
  
  # If you're using variable expiration times, also add:
  config.active_storage.urls_expire_in = 1.week
end 