FactoryBot.define do
  factory :army do
    name { "My Army" }
    game_system { create(:wargame) }
  end
end
