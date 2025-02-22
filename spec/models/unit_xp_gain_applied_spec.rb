require "rails_helper"

RSpec.describe UnitXpGainApplied, type: :model do
  context "associations" do
    it { should belong_to(:game) }
    it { should belong_to(:unit) }
    it { should belong_to(:unit_xp_gain_event) }
  end
end
