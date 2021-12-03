# frozen_string_literal: true

class CreateSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :slots do |t|
      t.integer :user_id
      t.string :name
      t.integer :health
      t.integer :mana
      t.integer :happiness
      t.integer :fatigue
      t.integer :money

      t.timestamps
    end
  end
end
