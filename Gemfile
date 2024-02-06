# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'activerecord'
gem 'connection_pool'
gem 'dotenv'
gem 'erb'
gem 'eu_central_bank'
gem 'monetize'
gem 'money'
gem 'pg'
gem 'puma'
gem 'rack-contrib'
gem 'rake'
gem 'redis'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'sinatra-contrib'
gem 'zeitwerk'

group :development, :test do
  gem 'annotate'
  gem 'debug', '>= 1.0.0'
  gem 'faker'
  gem 'sqlite3', platforms: :ruby
end

group :development do
  gem 'rubocop'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'ruby-lsp', require: false
  gem 'ruby-lsp-rspec', require: false
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'rspec'
  gem 'rspec-sidekiq'
  gem 'shoulda'
  gem 'simplecov'
end
