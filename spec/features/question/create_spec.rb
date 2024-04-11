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

    scenario 'Asks a question', js: true do

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      click_on 'Ask'
    
      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'text text text'
    end
    scenario 'Asks a question with errors', js: true do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end
    scenario 'asks a question with attached file' do 
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      attach_file 'question-files-create', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end    
  end
  
  scenario 'Unaunthenticated user tries to ask a question', js: true  do
    visit questions_path

    expect(page).to have_no_content "Ask question"
  end

  fcontext "multiple sessions" do
    scenario "question appears on another user's page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path
      end

      Capybara.using_session('guest') do
        visit questions_path
      end

      Capybara.using_session('user') do
        click_on 'Ask question'

        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'test text'
        click_on 'Ask'
        expect(page).to have_content 'Test question'
        expect(page).to have_content 'test text'
      end

      Capybara.using_session('guest') do

        expect(page).to have_content 'Test question'
      end
    end
  end  
end
