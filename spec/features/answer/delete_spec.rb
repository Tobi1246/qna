require "rails_helper"

feature "user can deleted answer" do
  given(:user) { create_list(:user, 2) }

  describe "Aunthenticaned user" do
    background do 
      sign_in(user[0])

      visit questions_path
    end    
    
    scenario "author deleted answer", js: true do
      question = user[0].created_questions.create!(title:"qwe", body: '123')
      visit questions_path
      click_on "qwe"
      fill_in 'answer-body-create', with: "Answer123"
      click_on "Answer"
      click_on "DeleteA"

      expect(page).to have_no_content "Answer123"
    end

    scenario "not author dont see button DeleteA" do
      question = user[1].created_questions.create!(title:"qwe", body: '123')
      visit questions_path
      click_on "qwe"

      expect(page).to have_no_button "DeleteA" 
    end
  end
end