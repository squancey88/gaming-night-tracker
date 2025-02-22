require "rails_helper"

RSpec.describe "unit_stat_modifiers/edit", type: :view do
  let(:unit_stat_modifier) { create(:unit_stat_modifier) }

  before(:each) do
    assign(:unit_stat_modifier, unit_stat_modifier)
  end

  it "renders the edit unit_stat_modifier form" do
    render

    assert_select "form[action=?][method=?]", unit_stat_modifier_path(unit_stat_modifier), "post" do
      assert_select "input[name=?]", "unit_stat_modifier[cost]"
      assert_select "input[name=?]", "unit_stat_modifier[active]"
    end
  end
end
