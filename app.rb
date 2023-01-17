require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'bcrypt'

class Application < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/add_user' do
    user = User.new(
      "username": params[:username],
      "firstname": params[:firstname],
      "lastname": params[:lastname],
      "email": params[:email],
      "password": params[:password]
    )
    # add user to db
    user.save ? (redirect "/") : "Failed to add user!"
  end
end