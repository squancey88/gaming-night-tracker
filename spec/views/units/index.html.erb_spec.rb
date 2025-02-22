require "rails_helper"

RSpec.describe "units/index", type: :view do
  let(:army_list) { create(:army_list) }
  let!(:units) { create_list(:unit, 2, army_list:) }

  before(:each) do
    pagy, units_list = pagy(army_list.units)
    assign(:army_list, army_list)
    assign(:units, units_list)
    assign(:pagy, pagy)
  end

  it "renders a list of units" do
    render
    expect(rendered).to have_css(".card", count: 2)
  end
end
