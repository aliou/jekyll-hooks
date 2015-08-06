require './lib/builder'

class Hooks < Sinatra::Base

  post '/' do
    data = JSON.parse(request.body.read)
    begin
      repo = data.fetch('repository').fetch('name')
      Builder.new(repo).update
    rescue
      return 500
    end

    200
  end
end
