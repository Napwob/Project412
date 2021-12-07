# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, &:timestamps
    change_table :users, bulk: true do |t|
      t.integer :health, default: 100
      t.integer :mana, default: 30
      t.integer :happiness, default: 5
      t.integer :fatigue, default: 0
      t.integer :money, default: 5000
      t.string :name
    end
  end
end
