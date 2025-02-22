require "rails_helper"

RSpec.describe UnitTraitCategoryMapping, type: :model do
  let(:game_system) { create(:wargame) }
  let(:unit_trait_category) { create(:unit_trait_category, game_system:) }
  let(:unit) { create(:unit) }

  describe "associations" do
    it { should belong_to(:unit_trait_category) }
    it { should belong_to(:mapped_to) }
  end

  describe "precedence" do
    it "should return correct value for order" do
      expect(described_class.new(mapped_to: unit, unit_trait_category:, order: 1).precedence).to eq("primary")
      expect(described_class.new(mapped_to: unit, unit_trait_category:, order: 2).precedence).to eq("secondary")
    end
  end
end
