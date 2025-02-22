FactoryBot.define do
  factory :unit_stat_definition do
    game_system { create(:wargame) }
    name { "MyString" }
    label { "MyString" }
    stat_type { :standard_stat }
    min { 0 }
    max { 10 }
    sort { 1 }
  end
end
