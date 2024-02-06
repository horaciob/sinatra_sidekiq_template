# frozen_string_literal: true

require 'json'
require 'sinatra/json'
require 'sinatra/reloader' if development?
module Controllers
  class BaseController < Sinatra::Base
    use Rack::JSONBodyParser

    set :json_content_type, :json
    set :show_exceptions, false
    set :after_handler, true
    set :views, proc { File.join(root, '../../app/views') }

    configure :development do
      register Sinatra::Reloader
    end

    error ::ActiveRecord::RecordNotFound do
      halt 404, { error: env['sinatra.error'].message }.to_json
    end

    error ActiveRecord::RecordNotUnique do
      halt 422, { error: 'There is another resource is not unique' }.to_json
    end

    error ActiveRecord::RecordInvalid, ActiveRecord::NotNullViolation do
      halt 422, { error: env['sinatra.error'].message }.to_json
    end

    not_found do
      { error: 'Oh no, this does not exists.' }.to_json
    end
  end
end
