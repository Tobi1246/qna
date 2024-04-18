require 'rails_helper'

feature "user can coment question", %q{
  only login user can coment to question
  only login user can delete self question coment
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }

  scenario "Unaunthenticated user no see buttons" do
    visit question_path(question)

    expect(page).to have_no_button "Coment"
  end 

  describe "Authenticated user" do
    background do 
      sign_in user 
      visit question_path(question)
    end

    scenario "User see buttons" do
      within '.questions' do
        expect(page).to have_button "Coment"
      end
    end

    scenario "User click Coment button", js: true do
      within '.questions' do
        fill_in 'question_coment_body', with: 'coment created'
        click_on "Coment"

        expect(page).to have_content "coment created"
      end
    end

    scenario "User click Coment button whith error body", js: true do
      click_on "Coment"

      expect(page).to have_content "Body can't be blank"
    end

    scenario "User dont see button delete vote do not voted" do
      expect(page).to have_no_content "delete coment"
    end

    scenario "User can delete self question coment", js: true do
      within '.questions' do
        fill_in 'question_coment_body', with: 'coment question created'
        click_on "Coment"        
        click_on "delete coment"

        expect(page).to have_no_content "coment question created"
        expect(page).to have_no_content "delete coment"
      end      
    end
  end
  fcontext "multiple sessions" do
    scenario "question appears on another user's page", js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        within '.questions' do
          fill_in 'question_coment_body', with: 'coment created'
          click_on "Coment"

          expect(page).to have_content "coment created"
        end
      end

      Capybara.using_session('guest') do

        expect(page).to have_content "coment created"
      end
    end
  end    
end
