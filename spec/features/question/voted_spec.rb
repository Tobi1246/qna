require 'rails_helper'

feature "user can vote to answer", %q{
  only login user can vote to answer
  only login user can delete self answer
} do
  
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  scenario "Unaunthenticated user no see buttons" do
    visit question_path(question)

    expect(page).to have_no_button "Good"
    expect(page).to have_no_button "Bad"
  end 

  describe "Authenticated user" do
    background do 
      sign_in user 
      visit question_path(question)
    end

    scenario "User see buttons" do
      within '.questions' do
        expect(page).to have_button "Good"
        expect(page).to have_button "Bad"
      end
    end

    scenario "User click Good button", js: true do
      within '.questions' do
        click_on "Good"

        expect(page).to have_content "votes result:1"
      end
    end

    scenario "User click Bad button", js: true do
      within '.questions' do
        click_on "Bad"

        expect(page).to have_content "votes result:-1"
      end
    end

    scenario "User dont see button delete vote do not voted" do
      expect(page).to have_no_content "delete my vote"
    end

    scenario "User can delete self vote", js: true do
      within '.questions' do
        click_on "Bad"
        visit question_path(question)
        click_on "delete my vote"

        expect(page).to have_content "Ur vote delete"
      end      
    end
  end     
end
