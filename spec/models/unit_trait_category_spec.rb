require "rails_helper"

RSpec.describe UnitTraitCategory, type: :model do
  describe "associations" do
    it { should belong_to(:game_system) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
