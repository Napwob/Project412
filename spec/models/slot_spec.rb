require 'rails_helper'
require 'support/factory_bot'

RSpec.describe Slot, type: :model do
  describe '#base_init' do
    it 'slot initialisation' do
      (slot = described_class.new).base_init
      expect(slot.happiness).to eq 5
    end
  end

  describe '#load_from_slot' do
    it 'load data from slot' do
      (user = build(:user)).init_stats
      user.money = 50_000

      (slot = described_class.new).base_init
      slot.set_from_user(user, 'saved_game')
      expect(slot.money).to eq 50_000
    end
  end
end
