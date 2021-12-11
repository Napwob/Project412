require 'rails_helper'

# RSpec.describe 'Signing in', type: :feature do
describe 'Pages Interactions' do
  before do
    create :user, name: 'Username', email: 'person@example.com', password: 'password'
  end

  it 'user signing in using invalid password' do
    sign_in_with 'person@example.com', 'wrong password'
    expect(page).to have_current_path(new_user_session_path, ignore_query: true)
  end

  it 'user signing out' do
    sign_in_with 'person@example.com', 'password'
    click_link('Sign Out')
    expect(page).to have_current_path(root_path, ignore_query: true) and have_content('Welcome, Stranger')
  end

  it 'user signing in using valid email and password' do
    sign_in_with 'person@example.com', 'password'
    expect(page).to have_current_path(root_path, ignore_query: true)
  end

  it 'user edit own profile' do
    sign_in_with 'person@example.com', 'password'
    edit_data_with 'Username1', 'person@example.com', 'password'
    expect(page).to have_current_path(root_path, ignore_query: true) and have_content('Welcome, Username1')
  end

  it 'user click Help' do
    sign_in_with 'person@example.com', 'password'
    click_link('Help')
    expect(page).to have_current_path(help_path, ignore_query: true)
  end

  it 'user click Game' do
    sign_in_with 'person@example.com', 'password'
    click_link('Game')
    expect(page).to have_current_path(game_path, ignore_query: true)
  end

  it 'user singing out after getting into Game' do
    sign_in_with 'person@example.com', 'password'
    click_link('Game')
    click_link('Sign Out')
    expect(page).to have_current_path(root_path, ignore_query: true)
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
