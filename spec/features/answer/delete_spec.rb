require "rails_helper"

feature "user can deleted answer" do
  given(:user) { create_list(:user, 2) }
  given(:question) { create(:question, author: user[0]) }

  describe "Aunthenticaned user" do
    background do 
      sign_in(user[0])

      visit question_path(question)
    end    
    
    scenario "author deleted answer", js: true do
      fill_in 'answer-body-create', with: "Answer123"
      click_on "Answer"
      click_on "DeleteA"

      expect(page).to have_no_content "Answer123"
    end

    scenario "author answer can delete one of attached file", js: true do

      fill_in 'answer-body-create', with: "Answer123"
      attach_file 'answer-files-create', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Answer'

      first('.files_answer').click_link 'delete file'
      
      expect(page).to have_no_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario "not author dont see button DeleteA" do
      expect(page).to have_no_button "DeleteA" 
    end
  end
end