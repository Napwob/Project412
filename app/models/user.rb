# frozen_string_literal: true

require_relative 'user_actions'
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  include UserActions
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
    if self.mana.negative?
      self.mana = 0
      self.happiness -= 1
    end

    if self.mana > 100
      self.health = self.health - ((self.mana - 100) / 4)
      self.mana = 100
    end
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
end
