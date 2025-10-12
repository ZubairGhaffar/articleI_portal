# Gemfile
source "https://rubygems.org"

gem "rails", "~> 8.0.3"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"



gem "letter_opener"

gem "dotenv-rails", groups: [ :development, :test ]



# Essential gems for your app
gem "devise"
gem "image_processing", "~> 1.2"
gem "mini_magick"
gem "friendly_id"
gem "kaminari"

gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "cssbundling-rails", "~> 1.4"
