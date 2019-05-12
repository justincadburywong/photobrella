ruby '2.5.0'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'rack-cors'
gem "devise", ">= 4.6.0"
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'binding_of_caller'
  gem 'shoulda'
  gem 'chromedriver-helper'
  gem 'rails-controller-testing'
  gem 'faker'
  gem 'factory_bot_rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# ENV variables/secrets
gem 'figaro', '~> 1.1.1'

# Background jobs
gem 'sidekiq', "~> 5.0.4"

# Bootstrap
gem "bootstrap", ">= 4.3.1"
gem 'jquery-rails', '~> 4.3.1'
gem 'jquery-migrate-rails', '~> 1.2.1'
gem 'font-awesome-sass', '~> 5.0.9'

# Upload images to Amazon S3
gem 'aws-sdk', '~> 2.10.29'
# Required for validations
gem 'fastimage', '~> 2.1.0'
# Required for image versioning
gem 'image_processing', '~> 0.4.4'
# Required for image versioning
gem 'mini_magick', '~> 4.8.0'
# Shrine :)
gem 'shrine', '~> 2.6.1'

gem 'cloudflare-rails'
# gem 'actionpack-cloudflare'

# Assets
source 'https://rails-assets.org' do
  gem 'rails-assets-dropzone'
end
