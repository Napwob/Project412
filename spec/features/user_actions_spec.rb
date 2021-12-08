require "rails_helper"

RSpec.feature "User click on", :type => :feature do
  scenario "Go Job" do
    create:user, email:'person@example.com', password:'password'

    sign_in_with 'person@example.com', 'password'

    visit root_path

    expect(page).to have_selector(:link_or_button, 'Game')
  end



  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email' ,with: email
    fill_in 'Password' ,with: password
    click_button 'Log in'
  end
end