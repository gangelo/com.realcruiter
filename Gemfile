source 'https://rubygems.org'

ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Twitter bootstrap support
gem 'therubyracer'
gem 'less-rails' # Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails'

# For authentication.
gem 'devise', '~> 3.4.1'

group :development, :test do
  # Using RSpec and/or Capybara as opposed to MiniTest, fails to clean our database during testing.
  gem 'database_cleaner', '~> 1.3.0'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rspec-activemodel-mocks', '~> 1.0.1'
  gem 'webrat', '0.7.3'

  # Use Factory Girl for Active Record sample instance object creation: https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
  gem 'factory_girl_rails', '~> 4.0'
  # Use Shoulda Matchers for validation and association testing: https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers'
  # https://github.com/jnicklas/capybara  
  gem 'capybara'
  # For factory girl help.
  gem 'ffaker', '~> 1.25.0'
end

group :development do
  gem 'pry-rails'
end

# This code says that if the app is being deployed in the production environment,
# it should add the 'rails_12_factor' gem (which optimimizes Rails for Heroku) to the Gemset.
group :production do
  gem 'rails_12factor'
end

# Used to set up our rails app configuration on heroku using ENV.
gem 'figaro', '~> 1.1.0'

