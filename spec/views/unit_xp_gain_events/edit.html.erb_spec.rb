require "rails_helper"
require "support/shared_examples/game_system_form"

RSpec.describe "unit_xp_gain_events/edit", type: :view do
  let(:unit_xp_gain_event) { create(:unit_xp_gain_event) }

  before(:each) do
    assign(:unit_xp_gain_event, unit_xp_gain_event)
  end

  it_behaves_like "game system form"

  it "renders the edit unit_xp_gain_event form" do
    render

    assert_select "form[action=?][method=?]", unit_xp_gain_event_path(unit_xp_gain_event), "post" do
      assert_select "input[name=?]", "unit_xp_gain_event[name]"
      assert_select "input[name=?]", "unit_xp_gain_event[xp_gain]"
      assert_select "input[name=?]", "unit_xp_gain_event[active]"
    end
  end
end
