require "rails_helper"

RSpec.describe "unit_stat_modifiers/index", type: :view do
  let(:game_system) { create(:wargame) }
  let!(:unit_stat_modifiers) { create_list(:unit_stat_modifier, 2, game_system:) }

  before(:each) do
    pagy, mod_list = pagy(game_system.unit_stat_modifiers)
    assign(:unit_stat_modifiers, mod_list)
    assign(:pagy, pagy)
  end

  it "renders a list of unit_stat_modifiers" do
    render
    expect(rendered).to have_css(".card", count: 2)
  end
end
