# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameForms::CampaignAttributesComponent, type: :helper do
  include ViewComponent::TestHelpers

  let(:game_system) { create(:wargame, :turn_based_with_campaign) }

  let(:game) { create(:game, game_system:) }

  before do
    form_with model: game do |form|
      render_inline(described_class.new(game:, user_player: game.players.first, form:))
    end
  end

  it "to render input" do
    expect(page).to have_css("input[name*='credits']")
  end
end
