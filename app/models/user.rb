# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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

  def fix_stats
    self.health = 100 if self.health > 100

    self.health = 0 if self.health.negative?

    if self.mana.negative?
      self.mana = 0
      self.happiness -= 1
    end
    self.mana = 100 if self.mana > 100

    self.fatigue = 100 if self.fatigue > 100
    self.fatigue = 0 if self.fatigue.negative?

    self.happiness = 10 if self.happiness > 10
  end

  def check_win_lose
    if self.money > 30_000
      save

      'You win! Now Valera can buy notebook and work at home, drinking while working.'
    elsif (self.happiness < -9) || (self.health < 1)
      save

      'You defeated! Valera was found dead.'
    else
      ''
    end
  end

  def go_job
    if mana > 60
      'You cannot go job: you are drunk.'
    else
      apply_stats(0, -30, 0, 30, 1250)

      "Unloved job brings Valera a stable income. At least when he's not drunk."
    end
  end
end
