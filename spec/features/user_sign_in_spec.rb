require 'rails_helper'

describe 'Path' do
  # describe 'Pages Interactions' do

  before do
    create :user, name: 'Username', email: 'person@example.com', password: 'password'
    create :user, name: 'Usernamewin', email: 'personwin@example.com', password: 'passwordwin', money: '55000'
  end

  describe '#new_user_session_path' do
    it 'when user signing in using invalid password' do
      sign_in_with 'person@example.com', 'wrong password'
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
    end

    it 'when user signing in using valid email and password' do
      sign_in_with 'person@example.com', 'password'
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end

  describe '#destroy_user_session_path' do
    before do
      sign_in_with 'person@example.com', 'password'
    end

    it 'when user signing out' do
      click_link('Sign Out')
      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    it 'when user singing out after getting into Game' do
      click_link('Game')
      click_link('Sign Out')
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end

  describe '#edit_user_registration_path' do
    before do
      sign_in_with 'person@example.com', 'password'
    end

    describe '.when user edit profile Name' do
      before do
        edit_data_with 'Username1', 'person@example.com', 'password'
      end

      it 'test for path correctence' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      it 'test for name change' do
        expect(page).to have_content('Username1')
      end
    end

    describe '.when user edit profile Email' do
      before do
        edit_data_with 'Username', 'person1@example.com', 'password'
      end

      it 'test for path correctence' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      it 'test for Email change' do
        click_link('Sign Out')
        sign_in_with 'person@example.com', 'password'
        expect(page).to have_content('Invalid Email or password.')
      end
    end

    describe '.when user delete profile' do
      it 'test for path correctence' do
        visit edit_user_registration_path
        click_button 'Cancel my account'
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      it 'test for profile delition' do
        visit edit_user_registration_path
        click_button 'Cancel my account'
        expect(page).to have_content('Welcome, Stranger')
      end
    end
  end

  describe '#help_path' do
    it 'when user click Help' do
      sign_in_with 'person@example.com', 'password'
      click_link('Help')
      expect(page).to have_current_path(help_path, ignore_query: true)
    end
  end

  describe '#game_path' do
    it 'when user click Valera button' do
      sign_in_with 'person@example.com', 'password'
      visit game_path
      click_link 'Valera'
      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    describe '.when user win' do
      before do
        sign_in_with 'personwin@example.com', 'passwordwin'
        visit game_path
      end

      it 'test for path correctence' do
        expect(page).to have_current_path(game_path, ignore_query: true)
      end

      it 'test for action correctence' do
        expect(page).to have_content("Valera say: Finally!\nNew Game Load Game")
      end
    end
  end

  describe '#root_path' do
    it 'when unlogged user click Please sign in to play' do
      visit root_path
      click_link 'Please, sign in to play'
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
    end

    it 'when logged user click Game' do
      sign_in_with 'person@example.com', 'password'
      click_link 'Game'
      expect(page).to have_current_path(game_path, ignore_query: true)
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
