# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require(:default, ENV.fetch('RACK_ENV', ''))
require 'active_record'
require 'sinatra/activerecord'
require 'debug' if %w[test development].include?(ENV['RACK_ENV'])

loader = Zeitwerk::Loader.new

Dotenv.load('.env', ".env.#{ENV.fetch('RACK_ENV', nil)}")

require_relative 'config/initializers/sidekiq'

['config/initializers', 'app', 'app/models', 'app/services'].each do |dir|
  loader.push_dir(dir)
end

loader.setup

# set :database
