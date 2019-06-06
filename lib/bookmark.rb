require 'pg'
require_relative 'model_helpers'

class Bookmark
  attr_reader :all, :url, :title

  def initialize(url,title)
    @url = url
    @title = title
  end

  def self.all
      conn = setting_database
      result = conn.exec( "SELECT * FROM bookmarks" )
      result.map { |row| Bookmark.new(row['url'],row['title']) }
  end

  def add
    conn = setting_database
    conn.exec("INSERT INTO bookmarks (url , title) VALUES ('#{@url}','#{@title}');")
  end

end
