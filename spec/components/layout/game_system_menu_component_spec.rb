# frozen_string_literal: true

require "rails_helper"

RSpec.describe Layout::GameSystemMenuComponent, type: :component do
  let(:game_system) { create(:wargame) }

  before do
    render_inline(described_class.new(game_system:))
  end

  it "should have a link to game system" do
    expect(page).to have_link(game_system.name)
  end
end
