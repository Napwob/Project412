require 'rails_helper'

describe 'Game' do
  before do
    create_user 'Username', 'person@example.com', 'password'
    visit game_path
  end

  it 'when unloged user get into' do
    click_link('Sign Out')
    visit game_path
    user_sees_notice 'Error! You not authorized.'
  end

  it 'check correctance of stats initialisations' do
    visit game_path
    expect(page).to have_css('p', text: 'Money: 5000₽')
  end

  describe '#Save Game' do
    before do
      visit new_slot_path
    end

    it 'when user click Save Game and use non-empty savename' do
      fill_in 'Name save', with: 'Save 1'
      click_button 'Save Game'
      expect(page).to have_current_path(game_path, ignore_query: true)
    end

    it 'when user click Save Game and rewrite save' do
      save_game 'Save_1'
      visit new_slot_path
      save_game 'Save_1'
      expect(page).to have_current_path(game_path, ignore_query: true)
    end

    it 'when user click Save Game and use empty savename' do
      fill_in 'Name save', with: ''
      click_button 'Save Game'
      user_sees_notice 'Invalid name save!'
    end

    it 'when unloged user get into' do
      click_link('Sign Out')
      visit new_slot_path
      user_sees_notice 'Error! You not authorized.'
    end
  end

  describe '#Load Game' do
    before do
      visit new_slot_path
      fill_in 'Name save', with: 'Save 1'
      click_button 'Save Game'
    end

    it 'when user click Load Game after save' do
      visit slots_path
      expect(page).to have_content('Save 1')
    end

    it 'when user load old save' do
      click_link 'Go Job'
      visit slots_path
      click_button 'Load Game'
      expect(page).to have_content('Money: 5000₽')
    end

    it 'when unloged user get into' do
      click_link('Sign Out')
      visit slots_path
      user_sees_notice 'Error! You not authorized.'
    end
  end

  describe '#New Game' do
    it 'when user click New Game after some actions' do
      click_link 'Go Job'
      click_link 'New Game'
      expect(page).to have_css('p', text: 'Money: 5000₽')
    end
  end

  describe '.GameActions' do
    describe '#Go Job' do
      it 'when user click Go Job' do
        click_link 'Go Job'
        user_sees_notice 'Valera say: Its been a hard day'
      end
    end

    describe '#Contemplate nature' do
      it 'when user click Contemplate nature' do
        click_link 'Contemplate nature'
        user_sees_notice 'Valera say: I wandered lonely as a cloud'
      end
    end

    describe '#Drink wine and watch TV series' do
      it 'when user click Drink wine and watch TV series' do
        click_link 'Drink wine and watch TV series'
        user_sees_notice 'Valera say: Ta-ta-tadada-ta...'
      end
    end

    describe '#Go to the bar' do
      it 'when user click Go to the bar' do
        click_link 'Go to the bar'
        user_sees_notice 'Valera say: Beer or not two beer?'
      end
    end

    describe '#Drink with marginal people' do
      it 'when user click Drink with marginal people' do
        click_link 'Drink with marginal people'
        user_sees_notice 'Valera say: Oj, MOROZ MOROOOOOZ...'
      end
    end

    describe '#Sing in the subway' do
      it 'when user click Sing in the subway' do
        click_link 'Sing in the subway'
        user_sees_notice 'Valera say: IM GONNA ROCK!!!'
      end
    end

    describe '#Sleep' do
      it 'when user click Sleep' do
        click_link('Sleep')
        user_sees_notice 'Valera say: zZzZzZ...'
      end
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

  def click_game
    visit root_path
    click_button 'Game'
  end

  def save_game(text)
    fill_in 'Name save', with: text
    click_button 'Save Game'
  end

  def user_sees_notice(text)
    expect(page).to have_content text
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
