require 'rails_helper'

describe 'Path' do
  # describe 'Pages Interactions' do

  before do
    create :user, name: 'Username', email: 'person@example.com', password: 'password'
  end

  describe '#new_user_session_path' do
    it 'user signing in using invalid password' do
      sign_in_with 'person@example.com', 'wrong password'
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
    end

    it 'user signing in using valid email and password' do
      sign_in_with 'person@example.com', 'password'
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end

  describe '#destroy_user_session_path' do
    it 'user signing out' do
      sign_in_with 'person@example.com', 'password'
      click_link('Sign Out')
      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    it 'user singing out after getting into Game' do
      sign_in_with 'person@example.com', 'password'
      click_link('Game')
      click_link('Sign Out')
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end

  describe '#edit_user_registration_path' do
    it 'user edit own profile' do
      sign_in_with 'person@example.com', 'password'
      edit_data_with 'Username1', 'person@example.com', 'password'
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end

  describe '#help_path' do
    it 'user click Help' do
      sign_in_with 'person@example.com', 'password'
      click_link('Help')
      expect(page).to have_current_path(help_path, ignore_query: true)
    end
  end

  describe '#game_path' do
    it 'user click Game' do
      sign_in_with 'person@example.com', 'password'
      click_link('Game')
      expect(page).to have_current_path(game_path, ignore_query: true)
    end
  end

  describe '#root_path' do
    it 'unloged user click Please, sign in to play' do
      visit root_path
      click_link 'Please, sign in to play'
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
    end
  end

  def create_user(name, email, password)
    visit new_user_registration_path
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign up'
  end

  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  def edit_data_with(name, email, password)
    visit edit_user_registration_path
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password confirmation', with: password
    fill_in 'Current password', with: password
    click_button 'Update'
  end
end
