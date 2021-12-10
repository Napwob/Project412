require 'rails_helper'

# RSpec.describe 'Signing in', type: :feature do
describe 'Signing in' do
  before do
    create :user, name: 'Username', email: 'person@example.com', password: 'password'
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

  it 'and edit profile' do
    sign_in_with 'person@example.com', 'password'
    edit_data_with 'Username1', 'person@example.com', 'password'
    expect(page).to have_content('Welcome, Username1')
  end

  def edit_data_with(name, email, password)
    visit edit_user_registration_path
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password confirmation', with: password
    fill_in 'Current password', with: password
    click_button 'Update'
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
