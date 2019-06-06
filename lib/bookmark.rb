require 'pg'
require_relative 'model_helpers'

class Bookmark
  attr_reader :all, :url, :title, :id
  
  def initialize(url,title, id)
    @url = url
    @title = title
    @id = id
  end

  def self.all
      conn = setting_database
      result = conn.exec( "SELECT * FROM bookmarks" )
      result.map { |row| Bookmark.new(row['url'],row['title'], row['id']) }
  end

  def self.add(url, title)
    conn = setting_database
    conn.exec("INSERT INTO bookmarks (url , title) VALUES ('#{url}','#{title}');")
  end

end
