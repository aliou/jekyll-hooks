require 'sinatra'
require 'json'

class Hooks < Sinatra::Base
  post '/' do
    data = JSON.parse(request.body.read)
    puts data
  end
end
