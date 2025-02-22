# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameForms::TurnBasedComponent, type: :component do
  let(:game_system) { create(:wargame, :turn_based) }
  let(:game) { create(:game, game_system:) }

  context "without data" do
    before do
      render_inline(described_class.new(game:, form: nil, user_player: nil))
    end

    it "should render add new turn button" do
      expect(page).to have_css(".btn", text: "Add Turn")
    end
  end

  context "with data" do
    before do
      player1 = game.players.first
      player2 = game.players.last

      player1.turns = [
        {primary: 0, secondary: 5},
        {primary: 10, secondary: 5}
      ]
      player2.turns = [
        {primary: 0, secondary: 8},
        {primary: 8, secondary: 8}
      ]
      player1.save!
      player2.save!
      game.reload
      render_inline(described_class.new(game:, form: nil, user_player: nil))
    end

    it "should render the correct number of inputs" do
      expect(page).to have_css('input[type="number"]', count: 8)
    end
  end
end
