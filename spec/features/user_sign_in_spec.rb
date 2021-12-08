require 'rails_helper'

RSpec.describe 'Signing in', type: :feature do
  before do
    create :user, email: 'person@example.com', password: 'password'
  end

  it 'notifies the user if his email or password is invalid' do
    sign_in_with 'person@example.com', 'wrong password'
    visit root_path
    expect(page).to have_selector(:link_or_button, 'Please, sign in to play')
  end

  it 'signs the user in successfully with a valid email and password' do
    sign_in_with 'person@example.com', 'password'
    visit root_path
    expect(page).to have_selector(:link_or_button, 'Game')
  end

  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  # def user_sees_notice(text)
  # expect(page).to have_css 'flash.alert',text: text
  # end
end
