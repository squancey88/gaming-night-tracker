require "rails_helper"

RSpec.describe "unit_stat_modifiers/new", type: :view do
  before(:each) do
    assign(:unit_stat_modifier, build(:unit_stat_modifier))
  end

  it "renders new unit_stat_modifier form" do
    render

    assert_select "form[action=?][method=?]", unit_stat_modifiers_path, "post" do
      assert_select "input[name=?]", "unit_stat_modifier[cost]"
      assert_select "input[name=?]", "unit_stat_modifier[active]"
    end
  end
end
