require 'sinatra/base'

class MyApp < Sinatra::Base
  set :klasses, {}
  set :foo, 'bar'

  get '/' do
    'Hello world!'
  end
  post '/evaluate/' do
    body = JSON.parse request.body.read
    klass = body['class_body']
    eval(klass)
    settings.klasses[body['class_name']] = MyApp.const_get body['class_name']
    ""
  end

  post '/run' do
    body = JSON.parse request.body.read
    klass = MyApp.const_get body['class_name']
    klass_instance = klass.new
    klass_instance.run body['arguments']
  end
end

