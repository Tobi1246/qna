require 'rails_helper'

feature 'User can edit his question', %q{
  In order to correct mistakes
  As an author of question
  I'd like ot be able to edit my question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  scenario 'Unauthenticated can not edit question' do
    visit question_path(question)

    expect(page).to have_no_link 'Edit'
  end

  describe 'Authenticated user' do 
    scenario 'edits his question', js: true do
      sign_in user
      visit question_path(question)
      
      within '.questions' do
        click_on 'Edit'
        fill_in 'question_title', with: 'title question'
        fill_in 'question_body', with: 'body question'
        click_on 'Save'

        expect(page).to have_no_content question.body
        expect(page).to have_no_content question.title
        expect(page).to have_content 'title question'
        expect(page).to have_content 'body question'
      end
    end
    scenario 'edits his question with errors', js: true do 
      sign_in user
      visit question_path(question)

      within '.questions' do
        click_on 'Edit'
        fill_in 'question_title', with: ""
        fill_in 'question_body', with: ''
        click_on 'Save'

        expect(page).to have_content question.body
        expect(page).to have_content question.title
      end      
      expect(page).to have_content "Body can't be blank"
      expect(page).to have_content "Title can't be blank"
    end
    scenario 'edit question with attached files', js: true do
      sign_in user
      visit question_path(question)

      within '.questions' do
        click_on 'Edit'
        fill_in 'question_title', with: 'title question'
        fill_in 'question_body', with: 'body question'
        attach_file 'question_files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'

        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end      
    
    scenario "tries to edit other user's question" do
      visit question_path(question)

      expect(page).to have_no_link 'Edit'
    end
  end

end
