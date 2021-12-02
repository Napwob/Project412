# frozen_string_literal: true

class Slot < ApplicationRecord
  def set_from_user(user, save_name)
    self.user_id = user.id
    self.health = user.health
    self.name = save_name
    self.mana = user.mana
    self.happiness = user.happiness
    self.money = user.money
    self.fatigue = user.fatigue
  end

  def base_init
    self.user_id = 0
    self.health = 100
    self.name = ''
    self.mana = 30
    self.happiness = 5
    self.fatigue = 0
    self.money = 5000
  end
end
