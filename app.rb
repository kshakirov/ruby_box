require 'sinatra/base'
require 'json'
require 'rest-client'
require_relative 'lib/engine'

class ConverterService < Sinatra::Base
  set :klasses, {}
  set :engine, Engine.new

  get '/' do
    'Testing Jruby Box!'
  end
  post '/lambda/ruby/converter/' do
    body = JSON.parse request.body.read, symbolize_names: true
    settings.engine.run(body).to_json
  end
end

