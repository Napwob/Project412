# frozen_string_literal: true

class AddUsersSaveData < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :health, :integer, default: 100
    add_column :users, :mana, :integer, default: 30
    add_column :users, :happiness, :integer, default: 5
    add_column :users, :fatigue, :integer, default: 0
    add_column :users, :money, :integer, default: 5000
  end
end
