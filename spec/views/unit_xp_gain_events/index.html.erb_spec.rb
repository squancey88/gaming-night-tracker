require "rails_helper"

RSpec.describe "unit_xp_gain_events/index", type: :view do
  let(:game_system) { create(:wargame) }
  let!(:unit_xp_gain_events) { create_list(:unit_xp_gain_event, 2, game_system:) }

  before(:each) do
    pagy, xp_gains = pagy(game_system.unit_xp_gain_events)
    assign(:unit_xp_gain_events, xp_gains)
    assign(:pagy, pagy)
  end

  it "renders a list of unit_xp_gain_events" do
    render
    expect(rendered).to have_css(".card", count: 3)
  end
end
