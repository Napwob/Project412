require 'rails_helper'

describe 'Path' do
  # describe 'Pages Interactions' do

  before do
    create :user, name: 'Username', email: 'person@example.com', password: 'password'
    create :user, name: 'Usernamewin', email: 'personwin@example.com', password: 'passwordwin', money: '49000'
  end

  describe '#new_user_registration_path' do
    it 'when user registrate account using free Email' do
      create_user 'Username123', 'person123@example.com', 'password'
      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    describe '.when user registrate account using owned Email' do
      it 'path correctence' do
        create_user 'Username', 'person@example.com', 'password'
        expect(page).to have_current_path('/users', ignore_query: true)
      end

      it 'user see notice' do
        create_user 'Username', 'person@example.com', 'password'
        expect(page).to have_content("1 error prohibited this user from being saved:\nEmail has already been taken")
      end
    end
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

    it 'when user click Back' do
      click_link 'Edit Profile'
      click_link 'Back'
      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    describe '.when user edit profile Name' do
      before do
        edit_data_with 'Username1', 'person@example.com', 'password'
      end

      it 'path correctence' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      it 'user see changes' do
        expect(page).to have_content('Username1')
      end
    end

    describe '.when user edit profile Email' do
      before do
        edit_data_with 'Username', 'person1@example.com', 'password'
      end

      it 'path correctence' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      it 'old email alert' do
        click_link('Sign Out')
        sign_in_with 'person@example.com', 'password'
        expect(page).to have_content('Invalid Email or password.')
      end
    end

    describe '.when user delete profile' do
      before do
        visit edit_user_registration_path
        click_button 'Cancel my account'
      end

      it 'path correctence' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      it 'welcome message notice' do
        expect(page).to have_content('Welcome, Stranger')
      end

      it 'trying to sign in by using old data' do
        sign_in_with 'person@example.com', 'password'
        expect(page).to have_content('Invalid Email or password.')
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

      it 'path correctence' do
        click_link 'Go Job'
        expect(page).to have_current_path(game_path, ignore_query: true)
      end

      it 'notice and actions correction' do
        click_link 'Go Job'
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
