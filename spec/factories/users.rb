FactoryBot.define do
  factory :user do
    email { 'example@mail.com' }
    password { '1' }
    health { 1 }
    mana { 1 }
    happiness { 1 }
    fatigue { 1 }
    money { 1 }
  end
end
