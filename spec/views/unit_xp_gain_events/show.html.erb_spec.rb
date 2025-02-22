require "rails_helper"

RSpec.describe "unit_xp_gain_events/show", type: :view do
  before(:each) do
    assign(:unit_xp_gain_event, create(:unit_xp_gain_event, name: "Test"))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Test/)
  end
end
