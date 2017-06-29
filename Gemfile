source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.1'
gem 'rails', '~> 5.0.3'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'rb-readline'
gem 'titler'

group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'spring-commands-rspec'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-rails'
  gem 'guard-rspec'
  gem 'vcr'
  gem 'rails-controller-testing'
  gem 'climate_control'
  gem 'guard-livereload'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'thin'
  gem 'better_errors'
  gem 'html2haml'
  gem 'annotate'
  gem 'growl'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'webmock'
  gem 'shoulda-matchers', '~> 3.0', require: false
  gem 'capybara-screenshot'
  gem 'rack_session_access'
  gem 'email_spec'
end
