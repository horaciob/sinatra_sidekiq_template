# frozen_string_literal: true

require './app'
require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/cron/web'

Sidekiq::Web.use Rack::Session::Cookie, secret: ENV.fetch('SESSION_SECRET', nil)
Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  [username, password] == [ENV.fetch('SIDEKIQ_USER'), ENV.fetch('SIDEKIQ_PASS')]
end

map '/admin' do
  run Rack::URLMap.new('/' => Sidekiq::Web)
end

map '/health' do
  run Controllers::HealthController
end

map '/merchants' do
  run Controllers::MerchantsController
end
