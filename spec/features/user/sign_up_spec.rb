require "rails_helper"

feature 'user registration new account', %q{
  ures create account to have possibility
  create answers and questions
} do


  scenario "user successfully create account" do
    visit root_path
    click_on 'sign_up'

    fill_in 'Email', with: "test@test.test"
    fill_in 'Password', with: "test123"
    fill_in 'Password confirmation', with: "test123"
    click_on 'Sign up'

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "user blank fill in" do
    visit root_path
    click_on 'sign_up'

    fill_in 'Email', with: "test@test.test"
    fill_in 'Password', with: "test123"
    click_on 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"    
  end

  scenario "user not possibility use email second time" do
    user = create(:user)
    visit root_path
    click_on 'sign_up'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content "Email has already been taken"    
  end

end

