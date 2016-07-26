require 'sinatra/base'
require './models/link'

class BookmarkManager < Sinatra::Base

  get '/links' do
     @links = Link.all
     erb :'links/index'
  end

#  get '/show' do
#    erb(:links)
#  end

  run! if app_file == $0

end
