source "https://rubygems.org"
ruby "3.2.4"

# Core gems
gem "rails", "~> 7.1.3"
gem "sprockets-rails"
gem "pg"
gem "puma"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "bootsnap", require: false

# Authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

# Storage
gem 'aws-sdk-s3', require: false
gem 'image_processing', '~> 1.2'
gem 'ruby-vips', '>= 2.1.0'

# Additional utilities
gem 'dotenv-rails'  # For .env file handling
gem 'friendly_id'   # For nice URLs
gem 'meta-tags'     # For SEO
gem 'kaminari'      # For pagination

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'     # For testing
  gem 'factory_bot_rails' # For test data
end

group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem 'better_errors'    # For better error pages
  gem 'binding_of_caller' # For better_errors REPL
end 