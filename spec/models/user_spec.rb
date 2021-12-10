require 'rails_helper'
require 'support/factory_bot'

RSpec.describe User, type: :model do
  describe '.Base' do
    it 'loading values from slot' do
      (user = build(:user)).init_stats
      (slot = Slot.new).base_init
      user.load_from_slot(slot)
      expect(user.money).to eq 5000
    end

    it 'setting value from user' do
      (user = build(:user)).init_stats
      (slot = Slot.new).base_init
      slot.set_from_user(user, 'saved_game')
      expect(slot.money).to eq 5000
    end

    it 'testing for victory game' do
      (user = build(:user)).init_stats
      user.money = 50_000
      expect(user.check_win_lose).to eq 'Valera say: Finally!'
    end

    it 'testing for depression' do
      (user = build(:user)).init_stats
      user.happiness = -10
      expect(user.check_win_lose).to eq 'Valera say: Farewell, cruel world...'
    end

    it 'testing for health' do
      (user = build(:user)).init_stats
      user.health = 0
      expect(user.check_win_lose).to eq 'Valera say: Farewell, cruel world...'
    end

    it 'continue game' do
      (user = build(:user)).init_stats
      user.happiness = 5
      user.money = 5000
      expect(user.check_win_lose).to eq ''
    end

    it 'fix stats' do
      (user = build(:user)).init_stats
      user.health = 1000
      user.apply_stats(200, -30, 100, 30, 1250)
      expect(user.health).to eq 100
    end
  end

  describe '.GameActions' do
    it 'go_job succesfully' do
      (user = build(:user)).init_stats
      expect(user.go_job).to eq 'Valera say: Its been a hard day'
    end

    it 'go_job failed' do
      (user = build(:user)).init_stats
      user.mana = 80
      expect(user.go_job).to eq 'Valera say: Jjob?... W-what is it?'
    end

    it 'contemplate nature' do
      (user = build(:user)).init_stats
      expect(user.contemplate_nature).to eq 'Valera say: I wandered lonely as a cloud'
    end

    it 'drink_wine_and_watch_tv_series succesfully' do
      (user = build(:user)).init_stats
      user.money = 200
      expect(user.drink_wine_and_watch_tv_series).to eq 'Valera say: Ta-ta-tadada-ta...'
    end

    it 'drink_wine_and_watch_tv_series failed' do
      (user = build(:user)).init_stats
      user.money = 199
      expect(user.drink_wine_and_watch_tv_series).to eq 'Valera say: Sorry, out of money'
    end

    it 'go_to_the_bar succesfully' do
      (user = build(:user)).init_stats
      user.money = 250
      expect(user.go_to_the_bar).to eq 'Valera say: Beer or not two beer?'
    end

    it 'go_to_the_bar failed' do
      (user = build(:user)).init_stats
      user.money = 249
      expect(user.go_to_the_bar).to eq 'Valera say: Sorry, out of money'
    end

    it 'drink_with_marginal_people succesfully' do
      (user = build(:user)).init_stats
      user.money = 1500
      expect(user.drink_with_marginal_people).to eq 'Valera say: Oj, MOROZ MOROOOOOZ...'
    end

    it 'drink_with_marginal_people failed' do
      (user = build(:user)).init_stats
      user.money = 1490
      expect(user.drink_with_marginal_people).to eq 'Valera say: Sorry, out of money'
    end

    it 'sleep succesfully' do
      (user = build(:user)).init_stats
      expect(user.sleep).to eq 'Valera say: zZzZzZ...'
    end

    it 'sleep failed' do
      (user = build(:user)).init_stats
      user.mana = 60
      expect(user.sleep).to eq 'Valera say: zzz...one more shot...zzz'
    end

    it 'tired to sing' do
      (user = build(:user)).init_stats
      user.fatigue = 81
      expect(user.sing_in_the_subway).to eq 'Valera say: I need to sleep, not sing'
    end

    it 'sing succesfully' do
      (user = build(:user)).init_stats
      user.mana = 50
      expect(user.sing_in_the_subway).to eq 'Valera say: Near, far, wherever you are...'
    end

    it 'sing failed' do
      (user = build(:user)).init_stats
      user.mana = 10
      expect(user.sing_in_the_subway).to eq 'Valera say: IM GONNA ROCK!!!'
    end
  end
end
