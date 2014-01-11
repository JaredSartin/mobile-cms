source 'https://rubygems.org'

# Core
gem 'rails', '4.0.2'
gem 'mysql2', '0.3.13'

# Front end client
gem 'ember-rails', '0.14.1'
gem 'ember-source', '1.1.2'
gem 'emblem-rails', '0.2.0'

gem 'therubyracer', '0.12.0'
gem "less-rails", "2.4.2"
gem "less-rails-bootstrap", "3.0.6"
gem 'bootstrap-wysihtml5-rails', '0.3.1.23', require: "bootstrap-wysihtml5-rails"

# Assets
gem 'uglifier', '2.3.0'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'jquery-ui-rails', '4.1.1'
gem 'haml-rails', '0.4.0'
gem 'haml', '4.0.3'

# API
gem 'active_model_serializers', '0.8.1'
gem "rails-api", github: 'rails-api/rails-api'

# Auth
gem 'devise', '3.2.1'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'cancan', '1.6.10'

# Language
gem 'i18n', '0.6.5'
gem 'i18n-js', github: 'torandi/i18n-js'

gem 'paperclip', '3.5.2'
gem 'aws-sdk', '1.32.0'

group :development do
  gem 'quiet_assets', '1.0.2'
  gem 'bullet', '4.6.0'
end

group :development, :test do
  gem 'rspec-rails', '2.14.0'
  gem 'pry', '0.9.12.2'
  gem 'pry-remote', '0.1.7'
  gem 'fabrication', '2.9.0'
  gem 'faker', '1.2.0'
  # Use Capistrano for deployment
  # gem 'capistrano', '2.15.4'
  # gem 'capistrano-ext'
  # gem 'caplock'
end

group :test do
  gem 'launchy', '2.3.0'
  gem 'birdbath', '1.3.5'
  gem 'capybara', '2.1.0'
  gem 'poltergeist', '1.4.1'
  gem 'shoulda-matchers', '2.4.0'
  gem 'database_cleaner', '1.2.0'
  gem 'fire_poll', '1.2.0'
end

group :production do
  gem 'newrelic_rpm', '3.7.1.182'
end
