require "rails_helper"
require "support/shared_examples/game_system_form"

RSpec.describe "unit_traits/new", type: :view do
  before(:each) do
    assign(:unit_trait, create(:unit_trait))
  end

  it_behaves_like "game system form"

  it "renders new unit_trait form" do
    render
    assert_select "input[name=?]", "unit_trait[name]"
    assert_select "input[name=?]", "unit_trait[active]"
  end
end
