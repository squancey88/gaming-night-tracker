FactoryBot.define do
  factory :unit_xp_gain_event do
    name { "MyString" }
    description { "" }
    xp_gain { 1 }
    game_system { create(:wargame) }
    active { true }
  end
end
