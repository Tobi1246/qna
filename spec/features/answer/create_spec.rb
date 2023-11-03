require "rails_helper"

feature "User create answer" do

  given(:user) { create(:user) }

  describe "Aunthenticaned user" do
    background do 
      sign_in(user)
      visit questions_path
    end        

    scenario 'Create answer' do
      question = user.created_questions.create!(title:"qwe", body: '123')
      visit questions_path
      click_on "qwe"

      fill_in 'Body', with: "Answer123"
      click_on "Answer"
    
      expect(page).to have_content 'Answer123'
    end
    scenario 'Answer blank errors' do
      question = user.created_questions.create!(title:"qwe", body: '123')
      visit questions_path
      click_on "qwe"
      click_on 'Answer'

      expect(page).to have_content "Answer not create"
    end
  end
  scenario 'Unaunthenticated user can create answers' do
    question = user.created_questions.create!(title:"qwe", body: '123')
    visit questions_path
    click_on "qwe"

    expect(page).to have_no_content 'Answer' 
  end
end

