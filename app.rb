require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'bcrypt'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  register Sinatra::ActiveRecordExtension

  get '/' do
    return erb(:index)
  end
end