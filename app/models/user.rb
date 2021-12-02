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
    if self.mana > 100
      self.mana = 100 
    end

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
    if mana > 50 or fatigue < 60
      "Valera cannot go to work because of his condition"
    else
      "Valera goes to work"
      apply_stats(0, -30, 0, 30, 1250)
    end
  end

  def contemplate_nature
    "Valera contemplates nature"
    apply_stats(0, -10, 1, -10, 0)
  end

  def drink_wine_and_watch_tv_series
    if money < 20
      "Valera cannot drink wine and watch TV series, as he does not have enough money"
    else
      "Valera drinks wine and watches the TV series"
      apply_stats(-5, 30, -1, 10, -20)
    end
  end

  def go_to_the_bar
    if money < 100
      "Valera cannot go to the bar due to the fact that he does not have enough money"
    else
      "Valera goes to the bar"
      apply_stats(-10, 60, 1, 40, -100)
    end
  end

  def drink_with_marginal_people
    if money < 150
      "Valera cannot drink with marginal people, due to the fact that he does not have enough money"
    else
      "Valera drinks with marginal people" 
      apply_stats(-80, 90, 5, 80, -150)
  end

  def sing_in_the_subway
    "Valera sings in the subway"
    apply_stats(0, -10, 1, 20, +10)
    if mana > 40 and mana < 70
      apply_stats(0, 0, 0, 0, +50)
    end
  end

  def sleep
    "Valera is sleeping"
    apply_stats(0, -50, 0, -70, 0)
    if mana < 30
      apply_stats(90, 0, 0, 0, 0)
    end
    if mana > 70
      apply_stats(0, 0, -3, 0, 0)
    end
  end
end
