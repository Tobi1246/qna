require 'rails_helper'

feature 'User can create question', %q{
  In order to ger answer from a community
  As an authenticated user 
  I'd like to be able to ask the question
} do

  given(:user) { create(:user) }

  describe "Aunthenticaned user" do
    background do 
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end        

    scenario 'Asks a question' do

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      click_on 'Ask'
    
      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'text text text'
    end
    scenario 'Asks a question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end
  end
  
  scenario 'Unaunthenticated user tries to ask a question'  do
    visit questions_path

    expect(page).to have_no_content "Ask question"
  end
end
