ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './models/link'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base

 get '/links' do
    @links = Link.all
    @tags = Tag.all
    erb :'links/index'
 end

 get '/links/new' do
    erb :'links/new'

 end

 post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tag = Tag.first_or_create(name: params[:tag])
    links.tags << tag
    link.save
    redirect '/links'
 end

  run! if app_file == $0
end
