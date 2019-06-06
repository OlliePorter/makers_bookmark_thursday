require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :'bookmarks/home'
  end

  post '/add-bookmark' do
    @url = params[:url]
    bookmark = Bookmark.new(@url)
    bookmark.add
    redirect('/bookmarks')
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  run! if app_file == $0
end
