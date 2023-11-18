require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to have_no_link 'Edit'
  end

  describe 'Authenticated user' do 
    scenario 'edits his answer', js: true do
      sign_in user
      visit question_path(question)
      
      within '.answers' do
        click_on 'Edit'
        fill_in 'answer_body', with: 'edited answer'
        click_on 'Save'

        expect(page).to have_no_content answer.body
        expect(page).to have_content 'edited answer'
      end
    end
    scenario 'edits his answer with errors', js: true do 
      sign_in user
      visit question_path(question)

      within '.answers' do
        click_on 'Edit'
        fill_in 'answer_body', with: ""
        click_on 'Save'

        expect(page).to have_content answer.body
      end      
      expect(page).to have_content "Body can't be blank"
    end
    scenario 'edit answer with attached file', js: true do
      sign_in user
      visit question_path(question)

      within '.answers' do
        click_on 'Edit'
        fill_in 'answer_body', with: 'edited answer'
        attach_file 'answer_files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
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