ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'data_mapper_setup'

require_relative 'server'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/sessions'
require_relative 'controllers/users'

class BookmarkManager < Sinatra::Base

  use Rack::MethodOverride
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect '/sessions/new'
  end

  get '/navigation' do
    erb :'links/navigation'
  end

  run! if app_file == $0
end
