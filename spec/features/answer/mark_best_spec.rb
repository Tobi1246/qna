require 'rails_helper'

feature 'User can touch to best answer', %q{
  Unauthenticat user no see link
  Only authir click to best answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unaunthenticated user no see link' do
    visit question_path(question)

    expect(page).to have_no_link "Best Answer"
  end

  describe "Authenticated user" do
    background do 
      sign_in user 
      visit question_path(question)
    end

    scenario '(author) can choose best answer and afther click show link best answer', js: true do

      click_on "Best Answer"  

      expect(page).to have_content 'Best answer:'
      expect(page).to have_no_link "Best Answer"
    end

    scenario 'autor question see link Best Answer' do
      expect(page).to have_link "Best Answer"
    end
  end


end