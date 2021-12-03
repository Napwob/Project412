require 'rails_helper'
require 'support/factory_bot'

RSpec.describe User, type: :model do
  describe '.Base' do
    it 'load_from_slot' do
      (user = build(:user)).init_stats
      (slot = Slot.new).base_init
      user.load_from_slot(slot)
      expect(user.money).to eq 5000
    end

    it 'set_from_user' do
      (user = build(:user)).init_stats
      (slot = Slot.new).base_init
      slot.set_from_user(user, 'saved_game')
      expect(slot.money).to eq 5000
    end

    it 'victory_game' do
      (user = build(:user)).init_stats
      user.money = 50_000
      expect(user.check_win_lose).to eq \
        'You win! Now Valera can buy notebook and work at home, drinking while working.'
    end

    it 'defeat_game_depression' do
      (user = build(:user)).init_stats
      user.happiness = -10
      expect(user.check_win_lose).to eq 'You defeated! Valera was found dead.'
    end

    it 'defeat_game_bad_health' do
      (user = build(:user)).init_stats
      user.health = 0
      expect(user.check_win_lose).to eq 'You defeated! Valera was found dead.'
    end

    it 'continue_game' do
      (user = build(:user)).init_stats
      user.happiness = 5
      user.money = 5000
      expect(user.check_win_lose).to eq ''
    end

    it 'fix_stats' do
      (user = build(:user)).init_stats
      user.health = 1000
      user.apply_stats(200, -30, 100, 30, 1250)
      expect(user.health).to eq 100
    end
  end

  describe '.GameActions' do
    it 'go_job_success' do
      (user = build(:user)).init_stats
      expect(user.go_job).to eq 'Valera goes to work'
    end

    it 'go_job_failed' do
      (user = build(:user)).init_stats
      user.mana = 80
      expect(user.go_job).to eq 'Valera cannot go to work because of his condition'
    end

    it 'contemplate_nature' do
      (user = build(:user)).init_stats
      expect(user.contemplate_nature).to eq 'Valera contemplates nature'
    end

    it 'drink_wine_and_watch_tv_series' do
      (user = build(:user)).init_stats
      expect(user.drink_wine_and_watch_tv_series).to eq 'Valera drinks wine and watches the TV series'
    end

    it 'go_to_the_bar' do
      (user = build(:user)).init_stats
      expect(user.go_to_the_bar).to eq 'Valera goes to the bar'
    end

    it 'drink_with_marginal_people_success' do
      (user = build(:user)).init_stats
      expect(user.drink_with_marginal_people).to eq 'Valera drinks with marginal people'
    end

    it 'drink_with_marginal_people_failed' do
      (user = build(:user)).init_stats
      user.money = 149
      expect(user.drink_with_marginal_people).to eq 'Valera cannot drink with marginal people, due to the fact that he does not have enough money'
    end

    it 'sleep_good' do
      (user = build(:user)).init_stats
      expect(user.sleep).to eq 'Valera is sleeping good'
    end

    it 'sleep_bad' do
      (user = build(:user)).init_stats
      user.mana = 60
      expect(user.sleep).to eq 'Valera is sleeping bad'
    end

    it 'sing_good' do
      (user = build(:user)).init_stats
      user.mana = 50
      expect(user.sing_in_the_subway).to eq 'Valera sing in the subway really nice'
    end

    it 'sing_bad' do
      (user = build(:user)).init_stats
      user.mana = 10
      expect(user.sing_in_the_subway).to eq 'Valera sing in the subway not bad'
    end
  end
end
