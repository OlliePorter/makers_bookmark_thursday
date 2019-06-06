require 'pg'

feature 'index page' do
  scenario 'can run app and check index page content' do
    visit('/')
    expect(page).to have_content "Bookmark Manager"
  end
end

feature 'Bookmarks' do
  scenario 'can view all bookmarks' do
    conn = PG.connect( dbname: 'bookmark_manager_test')
    conn.exec("INSERT INTO bookmarks (url , title) VALUES ('http://www.makersacademy.com','Makers');")
    visit('/bookmarks')
    bookmarks = Bookmark.all
    expect(page).to have_content "Makers"
  end
end

feature 'Add bookmark' do
  scenario 'can submit a bookmark via a form' do
    visit('/')
    fill_in 'url', with: 'http://www.github.com'
    fill_in 'title', with: 'Github'
    click_button 'Submit'
    expect(page).to have_content('Github')
  end
end

feature 'delete bookmark' do
  scenario 'can delete a bookmark by pressing a button' do
    visit('/')
    fill_in 'url', with: 'http://www.github.com'
    fill_in 'title', with: 'Github'
    click_button 'Submit'
    click_button 'Delete'
    expect(page).not_to have_content('Github')
  end
end
