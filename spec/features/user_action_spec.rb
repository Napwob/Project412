require 'rails_helper'

# RSpec.describe 'User', type: :feature do
describe 'User' do
  before do
    create_user 'Username', 'person@example.com', 'password'
    click_game
  end

  it 'initialise' do
    visit game_path
    expect(page).to have_css('p', text: 'Money: 5000₽')
  end

  it 'click Save Game' do
    visit new_slot_path
    fill_in 'Name save', with: 'Save 1'
    click_button 'Save Game'
    expect(page).to have_content('Valera Life Stats')
  end

  it 'click Load Game after save' do
    visit new_slot_path
    fill_in 'Name save', with: 'Save 1'
    click_button 'Save Game'
    visit slots_path
    expect(page).to have_content('Save 1')
  end

  it 'click Save Game and use empty Save Name' do
    visit new_slot_path
    fill_in 'Name save', with: ''
    click_button 'Save Game'
    expect(page).to have_content('Invalid name save!')
    # expect(page).to have_css 'flash.alert',text:'Invalid name save!'
  end

  it 'click Go Job' do
    visit game_path
    click_on('Go Job')
    expect(page).to have_content('6250')
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

  def user_sees_notice(text)
    expect(page).to have_css 'flash.notice', text: text
  end

  def reload_page
    visit current_path
  end
end
