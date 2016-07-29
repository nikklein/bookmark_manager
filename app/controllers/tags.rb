class BookmarkManager < Sinatra::Base
  post '/tags/filter' do
    tag = Tag.first(name: params[:filter_tag])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end
end
