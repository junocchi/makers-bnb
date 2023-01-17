require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end


  get '/login' do
    return erb(:login)
  end

  get '/createspace' do
    return erb(:createspace)
  end
end
