# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def load_from_slot(slot)
    self.health = slot.health
    self.mana = slot.mana
    self.happiness = slot.happiness
    self.fatigue = slot.fatigue
    self.money = slot.money

    save
  end

  def init_stats
    self.health = 100
    self.mana = 30
    self.happiness = 5
    self.fatigue = 0
    self.money = 5000
    save
  end

  def apply_stats(health, mana, happiness, fatigue, money)
    self.health += health
    self.mana += mana
    self.happiness += happiness
    self.fatigue += fatigue
    self.money += money
    fix_stats
    save
  end
  
  def fix_mana
    return unless self.mana.positive?

    self.mana = 0
    self.happiness -= 1

    return unless self.mana < 100

    self.health = self.health - ((self.mana - 100) / 4)
    self.mana = 100
  end

  def fix_stats
    fix_mana

    self.health = 100 if self.health > 100
    self.health = 0 if self.health.negative?

    self.fatigue = 100 if self.fatigue > 100
    self.fatigue = 0 if self.fatigue.negative?

    self.happiness = 10 if self.happiness > 10
  end

  def check_win_lose
    if self.money >= 50_000
      save

      'Valera say: Finally!'
    elsif (self.happiness < -9) || (self.health < 1)
      save

      'Valera say: Farewell, cruel world...'
    else
      ''
    end
  end

  def go_job
    if (mana > 50) || (fatigue > 60)
      'Valera say: Jjob?... W-what is it?'
    else
      apply_stats(0, -30, 0, 30, 1250)
      'Valera say: Its been a hard day'
    end
  end

  def contemplate_nature
    apply_stats(0, -10, 1, -10, 0)
    'Valera say: I wandered lonely as a cloud'
  end

  def drink_wine_and_watch_tv_series
    if money < 200
      'Valera say: Sorry, out of money'
    else
      apply_stats(-5, 30, 1, 10, -20)
      'Valera say: Ta-ta-tadada-ta...'
    end
  end

  def go_to_the_bar
    if money < 250
      'Valera say: Sorry, out of money'
    else
      apply_stats(-10, 60, 2, 40, -100)
      'Valera say: Beer or not two beer?'
    end
  end

  def drink_with_marginal_people
    if money < 1500
      'Valera say: Sorry, out of money'
    else
      apply_stats(-80, 90, 5, 80, -1500)
      'Valera say: Oj, MOROZ MOROOOOOZ...'
    end
  end

  def sing_in_the_subway
    'Valera say: I need to sleep, not sing' if fatigue > 80
    if (mana > 30) && (mana < 70)
      apply_stats(0, 0, 0, 0, +50)
      'Valera say: Near, far, wherever you are...'
    else
      apply_stats(0, -10, 1, 20, +10)
      'Valera say: IM GONNA ROCK!!!'
    end
  end

  def sleep
    if mana < 40
      apply_stats(90, -50, 0, -70, 0)
      'Valera say: zZzZzZ...'
    else
      apply_stats(0, -50, -3, -70, 0)
      'Valera say: zzz...one more shot...zzz'
    end
  end
end
