require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'bcrypt'
require_relative 'lib/space'
require_relative 'lib/user'
require_relative 'lib/availability'
require_relative 'lib/request'

class Application < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end
end