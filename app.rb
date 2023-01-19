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
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/spaces'
    else
      erb(:login)
    end    
  end

  get '/spaces' do
    redirect_if_not_logged_in
    @spaces = Space.all
    return erb(:spaces)
  end

  get '/create-space' do
    redirect_if_not_logged_in
    return erb(:create_space)
  end

  get '/requests' do
    redirect_if_not_logged_in
    return erb(:requests)
  end

  helpers do

    def logged_in?
      !!session[:id]
    end

    def redirect_if_not_logged_in
      redirect '/login' if !logged_in?
    end
  end
end
