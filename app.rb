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
  enable :session
  
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/login' do
    erb(:login)
  end

  post '/login' do
    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = [{ 'name' => 'California' }, { 'name' => 'Texas' }]
    return erb(:spaces)
  end

  get '/create-space' do
    return erb(:create_space)
  end

  get '/requests' do
    return erb(:requests)
  end
end
