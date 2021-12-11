require 'rails_helper'
require 'support/factory_bot'

RSpec.describe User, type: :model do
  describe '#set_from_user' do
    it 'setting value from user' do
      (user = build(:user)).init_stats
      (slot = Slot.new).base_init
      slot.set_from_user(user, 'saved_game')
      expect(slot.money).to eq 5000
    end
  end

  describe '#load_from_slot' do
    it 'loading values from slot' do
      (user = build(:user)).init_stats
      (slot = Slot.new).base_init
      user.load_from_slot(slot)
      expect(user.money).to eq 5000
    end
  end

  describe '#check_win_lose' do
    it 'when money is equal 50000' do
      (user = build(:user)).init_stats
      user.money = 50_000
      expect(user.check_win_lose).to eq 'Valera say: Finally!'
    end

    it 'when hapinness is equal -10' do
      (user = build(:user)).init_stats
      user.happiness = -10
      expect(user.check_win_lose).to eq 'Valera say: Farewell, cruel world...'
    end

    it 'when health is equal 0' do
      (user = build(:user)).init_stats
      user.health = 0
      expect(user.check_win_lose).to eq 'Valera say: Farewell, cruel world...'
    end

    it 'when stats are in average condition' do
      (user = build(:user)).init_stats
      user.health = 80
      user.happiness = 4
      user.money = 4721
      expect(user.check_win_lose).to eq ''
    end
  end

  describe '#fix_stats' do
    it 'fixing stats' do
      (user = build(:user)).init_stats
      user.health = 1000
      user.apply_stats(200, -30, 100, 30, 1250)
      expect(user.health).to eq 100
    end
  end

  describe '.GameActions' do
    describe '#go_job' do
      it 'when mana is lower than 80' do
        (user = build(:user)).init_stats
        expect(user.go_job).to eq 'Valera say: Its been a hard day'
      end

      it 'when mana is greater than 80' do
        (user = build(:user)).init_stats
        user.mana = 85
        expect(user.go_job).to eq 'Valera say: Jjob?... W-what is it?'
      end
    end

    describe '#contemplate_nature' do
      it 'contemplate nature' do
        (user = build(:user)).init_stats
        expect(user.contemplate_nature).to eq 'Valera say: I wandered lonely as a cloud'
      end
    end

    describe '#drink_wine_and_watch_tv_series' do
      it 'when money is greater than 200' do
        (user = build(:user)).init_stats
        user.money = 200
        expect(user.drink_wine_and_watch_tv_series).to eq 'Valera say: Ta-ta-tadada-ta...'
      end

      it 'when money is lower than 200' do
        (user = build(:user)).init_stats
        user.money = 199
        expect(user.drink_wine_and_watch_tv_series).to eq 'Valera say: Sorry, out of money'
      end
    end

    describe '#go_to_the_bar' do
      it 'when money is greater than 250' do
        (user = build(:user)).init_stats
        user.money = 250
        expect(user.go_to_the_bar).to eq 'Valera say: Beer or not two beer?'
      end

      it 'when money is lower than 250' do
        (user = build(:user)).init_stats
        user.money = 249
        expect(user.go_to_the_bar).to eq 'Valera say: Sorry, out of money'
      end
    end

    describe '#drink_with_marginal_people' do
      it 'when money is greater than 1500' do
        (user = build(:user)).init_stats
        user.money = 1500
        expect(user.drink_with_marginal_people).to eq 'Valera say: Oj, MOROZ MOROOOOOZ...'
      end

      it 'when money is lower than 1500' do
        (user = build(:user)).init_stats
        user.money = 1490
        expect(user.drink_with_marginal_people).to eq 'Valera say: Sorry, out of money'
      end
    end

    describe '#sleep' do
      it 'when mana is lower than 60' do
        (user = build(:user)).init_stats
        expect(user.sleep).to eq 'Valera say: zZzZzZ...'
      end

      it 'when mana is greater than 60' do
        (user = build(:user)).init_stats
        user.mana = 60
        expect(user.sleep).to eq 'Valera say: zzz...one more shot...zzz'
      end
    end

    describe '#sing_in_the_subway' do
      it 'when fatigue is greater than 80' do
        (user = build(:user)).init_stats
        user.fatigue = 81
        expect(user.sing_in_the_subway).to eq 'Valera say: I need to sleep, not sing'
      end

      it 'when mana is between 30 and 60' do
        (user = build(:user)).init_stats
        user.mana = 45
        expect(user.sing_in_the_subway).to eq 'Valera say: Near, far, wherever you are...'
      end

      it 'when mana isn\'t between 30 and 60' do
        (user = build(:user)).init_stats
        user.mana = 10
        expect(user.sing_in_the_subway).to eq 'Valera say: IM GONNA ROCK!!!'
      end
    end
  end
end
