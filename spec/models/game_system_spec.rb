require "rails_helper"

RSpec.describe GameSystem, type: :model do
  let(:game_system) { create(:wargame, name: "Test") }
  let(:blank_game_system) { GameSystem.new }

  context "associations" do
    it { should have_many(:games) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
  end

  context "attributes" do
    it { expect(game_system).to have_attributes(name: "Test") }
  end

  context "#setup_game_data" do
    it "should return hash" do
      expect(blank_game_system.setup_game_data).to eq({})
    end
  end

  context "#setup_player_data" do
    it "should return hash" do
      expect(blank_game_system.setup_player_data(nil)).to eq({})
    end
  end

  context "#set_winners" do
    it "should raise exception" do
      expect { blank_game_system.set_winners(nil) }.to raise_error(NotImplementedError)
    end
  end

  context "#game_data_form_components" do
    it "should return array" do
      expect(blank_game_system.game_data_form_components(nil)).to eq []
    end
  end

  context "#player_form_components" do
    it "should return array" do
      expect(blank_game_system.player_form_components).to eq []
    end
  end
end
