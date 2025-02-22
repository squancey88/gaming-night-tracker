require "rails_helper"

RSpec.describe Team, type: :model do
  context "associations" do
    it { should belong_to(:gaming_group) }
    it { should have_many(:team_members) }
    it { should have_many(:users) }
    it { should have_many(:players) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it "should require a name" do
      team = Team.new(name: nil)
      expect(team.valid?).to be false
    end
  end

  context "#display_name" do
    it "should be name" do
      team = create(:team, name: "Best Team")
      expect(team.display_name).to eq "Best Team"
    end
  end
end
