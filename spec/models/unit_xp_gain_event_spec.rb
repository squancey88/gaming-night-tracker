require "rails_helper"

RSpec.describe UnitXpGainEvent, type: :model do
  describe "associations" do
    it { should belong_to(:game_system) }
  end
end
