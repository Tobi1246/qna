require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/Tobi1246/67ee6048b88157a21f9e4d2c9bb7f706' }
  given(:url) { 'https://www.google.by/' }
  given(:url_2) { 'https://ya.ru/' }

  background do 
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
  end 

  scenario 'User adds link when asks question' do

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My url'
    fill_in 'Url path', with: url

    click_on 'Ask'

    expect(page).to have_link 'My url', href: url
  end

  scenario 'User adds link gist when asks question', js: true do

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url path', with: gist_url

    click_on 'Ask'

    within '.questions' do
      expect(page).to have_css '.gist'
    end
  end  

end
