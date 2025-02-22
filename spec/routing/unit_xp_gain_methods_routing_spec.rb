require "rails_helper"

RSpec.describe UnitXpGainEventsController, type: :routing do
  let(:game_system) { create(:wargame) }
  describe "routing" do
    it "routes to #index" do
      expect(get: "/unit_xp_gain_events?game_system_id=#{game_system.id}").to route_to("unit_xp_gain_events#index", game_system_id: game_system.id)
    end

    it "routes to #new" do
      expect(get: "/unit_xp_gain_events/new?game_system_id=#{game_system.id}").to route_to("unit_xp_gain_events#new", game_system_id: game_system.id)
    end

    it "routes to #show" do
      expect(get: "/unit_xp_gain_events/1").to route_to("unit_xp_gain_events#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/unit_xp_gain_events/1/edit").to route_to("unit_xp_gain_events#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/unit_xp_gain_events").to route_to("unit_xp_gain_events#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/unit_xp_gain_events/1").to route_to("unit_xp_gain_events#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/unit_xp_gain_events/1").to route_to("unit_xp_gain_events#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/unit_xp_gain_events/1").to route_to("unit_xp_gain_events#destroy", id: "1")
    end
  end
end
