require 'rails_helper'

feature 'User can delete question' do

  given(:user) { create(:user) }

  describe "Aunthenticaned user" do
    background do 
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end        

    scenario 'Author can deleted question' do

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      click_on 'Ask'
      click_on "DeleteQ"

      expect(page).to have_content "Question deleted"
    end
    scenario "author question can delete one of attached file", js: true do

      fill_in 'question_title', with: "qqwer"
      fill_in 'question_body', with: "12345"
      attach_file 'question-files-create', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'

      first('.files_question').click_link 'delete file'
      
      expect(page).to have_no_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end    
  end
  
  scenario 'Unaunthenticated user not have create question'  do
    visit questions_path
    expect(page).to have_no_button "Ask question"   
  end

  scenario 'Unaunthenticated user not have deleted question'  do
    question = user.created_questions.create!(title:"qwe", body: '123')
    visit questions_path
    click_on "qwe"

    expect(page).to have_content "qwe"
    expect(page).to have_no_button "DeleteQ"  
  end  
end
