require 'bookmark'

describe '#all' do

  it 'can display a list of bookmarks' do
    conn = PG.connect( dbname: 'bookmark_manager_test')
    conn.exec("INSERT INTO bookmarks (url) values ('http://www.makersacademy.com'),('http://www.google.com'),('http://www.facebook.com');")
    bookmarks = Bookmark.all
    expect(bookmarks[0].url).to eq("http://www.makersacademy.com")
  end
end

describe '#add' do
  it 'can add a new bookmark' do
    # bookmark = Bookmark.new('http://www.github.com','Github')
    Bookmark.add('http://www.github.com', 'Github')
    bookmarks = Bookmark.all
    expect(bookmarks[0].url).to eq('http://www.github.com')
    expect(bookmarks[0].title).to eq('Github')
  end
end
describe '#delete' do
  it 'can delete an existing bookmark' do
    bookmark = Bookmark.new('http://www.github.com','Github')
    bookmark.add
    bookmark.delete(1)
    bookmarks = Bookmark.all
    expect(bookmarks[0].url).not_to eq('http://www.github.com')
    expect(bookmarks[0].title).not_to eq('Github')
  end
end

# conn.exec( "SELECT * FROM bookmarks" ) do |result|
#   puts " id | url "
#   result.each do |row|
#     puts row.values_at('url')
#   end
# end
