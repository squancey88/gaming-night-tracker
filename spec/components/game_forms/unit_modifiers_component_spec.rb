# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameForms::UnitModifiersComponent, type: :helper do
  include ViewComponent::TestHelpers

  let(:game) { create(:game) }

  before do
    form_with model: game do |form|
      render_inline(described_class.new(game:, user_player: game.players.first, form:))
    end
  end

  it "should render an add Xp Gain button" do
    expect(page).to have_link("Add XP Gain")
  end
end
