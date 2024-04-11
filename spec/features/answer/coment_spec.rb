require 'rails_helper'

feature "user can coment question", %q{
  only login user can coment to question
  only login user can delete self question coment
} do
  
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario "Unaunthenticated user no see buttons" do
    visit question_path(question)

    expect(page).to have_no_button "Coment answer"
  end 

  describe "Authenticated user" do
    background do 
      sign_in user 
      visit question_path(question)
    end

    scenario "User see buttons" do
      within '.answers' do
        expect(page).to have_button "Coment"
      end
    end

    scenario "User click Coment button", js: true do
      within '.answers' do
        fill_in 'answer_coment_body', with: 'coment created'
        click_on "Coment answer"

        expect(page).to have_content "coment created"
      end
    end

    scenario "User click Coment button whith error body", js: true do
      click_on "Coment answer"

      expect(page).to have_content "Body can't be blank"
    end

    scenario "User dont see button delete vote do not voted" do
      expect(page).to have_no_content "delete coment"
    end

    scenario "User can delete self coment", js: true do
      within '.answers' do
        fill_in 'answer_coment_body', with: 'coment created'
        click_on "Coment answer"        
        click_on "delete coment"

        expect(page).to have_no_content "coment created"
        expect(page).to have_no_content "delete coment"
      end      
    end
  end     
end
