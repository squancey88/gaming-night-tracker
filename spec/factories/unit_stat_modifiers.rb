FactoryBot.define do
  factory :unit_stat_modifier do
    game_system { create(:wargame) }
    cost { 1 }
    active { true }
    name { Faker::Lorem.sentence }
    description {}
  end
end
