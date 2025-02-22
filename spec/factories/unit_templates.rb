FactoryBot.define do
  factory :unit_template do
    name { Faker::Lorem.word }
    cost { 1 }
    game_system { create(:wargame) }
    army
  end
end
