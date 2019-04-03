require 'sinatra/base'
require 'json'
require_relative 'lib/engine'

class ConverterService < Sinatra::Base
  set :klasses, {}
  set :engine, Engine.new

  get '/' do
    'Testing Jruby Box!'
  end
  post '/lambda/ruby/converter/' do
    body = JSON.parse request.body.read, symbolize_names: true
    settings.engine.run body
    ""
  end

  post '/run' do
    body = JSON.parse request.body.read
    klass = MyApp.const_get body['class_name']
    klass_instance = klass.new
    klass_instance.run body['arguments']
  end
end

