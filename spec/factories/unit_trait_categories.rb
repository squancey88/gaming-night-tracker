FactoryBot.define do
  factory :unit_trait_category do
    name { "MyString" }
    game_system { create(:wargame) }
  end
end
