FactoryBot.define do
  factory :equipment do
    name { "MyString" }
    description { "MyString" }
    cost { 1 }
    attach_to_list { false }
    attach_to_unit { false }
    game_system { create(:wargame) }
  end
end
