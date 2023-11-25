require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/Tobi1246/67ee6048b88157a21f9e4d2c9bb7f706' }
  given(:url) { 'https://www.google.by/' }
  given(:question) { create(:question, author: user) }

  background do 
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds link when asks answer', js: true do

    fill_in 'answer-body-create', with: "Answer123"

    fill_in 'Link name', with: 'My url'
    fill_in 'Url path', with: url

    click_on 'Answer'

    within '.answers' do
      expect(page).to have_link 'My url', href: url
    end
  end 

  scenario 'User adds link gist when asks answer', js: true do

    fill_in 'answer-body-create', with: "Answer123"

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url path', with: gist_url

    click_on 'Answer'

    visit question_path(question)

    within '.answers' do
      expect(page).to have_css '.gist'
    end
  end
end
