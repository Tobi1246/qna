require 'rails_helper'

feature 'user delete session', %q{
  User quit in accout
} do
  given(:user) { create(:user) }
  
  scenario "click to log_out" do
    sign_in(user)

    click_on 'log_out'
    expect(page).to have_content "Signed out successfully."
  end
end
