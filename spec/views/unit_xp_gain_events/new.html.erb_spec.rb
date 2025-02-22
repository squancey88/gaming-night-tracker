require "rails_helper"
require "support/shared_examples/game_system_form"

RSpec.describe "unit_xp_gain_events/new", type: :view do
  let(:game_system) { create(:wargame) }
  before(:each) do
    assign(:unit_xp_gain_event, UnitXpGainEvent.new(game_system:))
  end

  it_behaves_like "game system form"

  it "renders new unit_xp_gain_event form" do
    render

    assert_select "form[action=?][method=?]", unit_xp_gain_events_path, "post" do
      assert_select "input[name=?]", "unit_xp_gain_event[name]"
      assert_select "input[name=?]", "unit_xp_gain_event[xp_gain]"
      assert_select "input[name=?]", "unit_xp_gain_event[active]"
    end
  end
end
