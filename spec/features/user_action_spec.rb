require 'rails_helper'

# RSpec.describe 'User', type: :feature do
describe 'Game Actions' do
  before do
    create_user 'Username', 'person@example.com', 'password'
    click_game
  end

  it 'correct user initialisation' do
    visit game_path
    expect(page).to have_css('p', text: 'Money: 5000₽')
  end

  it 'when user click Save Game and use non-empty savename' do
    visit new_slot_path
    fill_in 'Name save', with: 'Save 1'
    click_button 'Save Game'
    expect(page).to have_current_path(game_path, ignore_query: true)
  end

  it 'when user click Save Game and use empty savename' do
    visit new_slot_path
    fill_in 'Name save', with: ''
    click_button 'Save Game'
    expect(page).to have_content('Invalid name save!')
    # expect(page).to have_css 'flash.alert',text:'Invalid name save!'
  end

  it 'when user click Load Game after save' do
    visit new_slot_path
    fill_in 'Name save', with: 'Save 1'
    click_button 'Save Game'
    visit slots_path
    expect(page).to have_content('Save 1')
  end

  it 'when user click Go Job' do
    make_default_stats
    click_link('Go Job')
    expect(page).to have_content('Valera say: Its been a hard day') and have_content('Money: 6250₽')
    # expect(page).to have_content('Money: 6250₽')
  end

  it 'when user click Contemplate nature' do
    make_default_stats
    click_link('Contemplate nature')
    expect(page).to have_content('Valera say: I wandered lonely as a cloud')
  end

  it 'when user click Drink wine and watch TV series' do
    make_default_stats
    click_link('Drink wine and watch TV series')
    expect(page).to have_content('Valera say: Ta-ta-tadada-ta...') and have_content('Money: 4800₽')
    # expect(page).to have_content('Money: 4800₽')
  end

  it 'when user click Go to the bar' do
    make_default_stats
    click_link('Go to the bar')
    expect(page).to have_content('Valera say: Beer or not two beer?') and have_content('Money: 4750₽')
    # expect(page).to have_content('Money: 4750₽')
  end

  it 'when user click Drink with marginal people' do
    make_default_stats
    click_link('Drink with marginal people')
    expect(page).to have_content('Valera say: Oj, MOROZ MOROOOOOZ...') and have_content('Money: 3500₽')
    # expect(page).to have_content('Money: 3500₽')
  end

  it 'when user click Sing in the subway' do
    make_default_stats
    click_link('Sing in the subway')
    expect(page).to have_content('Valera say: IM GONNA ROCK!!!') and have_content('Money: 5010₽')
    # expect(page).to have_content('Money: 5010₽')
  end

  it 'when user click Sleep' do
    make_default_stats
    click_link('Sleep')
    expect(page).to have_content('Valera say: zZzZzZ...') and have_content('Money: 5000₽')
    # expect(page).to have_content('Money: 5000₽')
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

  def make_default_stats
    visit game_path
    click_link 'New Game'
  end

  def user_sees_notice(text)
    expect(page).to have_css 'flash.notice', text: text
  end

  def reload_page
    visit current_path
  end
end
