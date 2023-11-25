require "rails_helper"

feature "User create answer" do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }

  describe "Aunthenticaned user" do
    background do 
      sign_in(user)
      visit question_path(question)
    end        

    scenario 'Create answer', js: true do
      fill_in 'answer-body-create', with: "Answer123"
      click_on "Answer"
    
      expect(page).to have_content 'Answer123'
    end
    scenario 'Answer blank errors', js: true do
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
    end
    scenario 'create answer with attached file', js: true do 
      fill_in 'answer-body-create', with: 'Test answer'

      attach_file 'answer-files-create', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Answer'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end      
  end
  scenario 'Unaunthenticated user can create answers', js: true do
    visit question_path(question)

    expect(page).to have_no_content 'Answer' 
  end
end

