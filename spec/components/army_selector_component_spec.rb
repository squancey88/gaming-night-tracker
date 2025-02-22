# frozen_string_literal: true

require "rails_helper"

RSpec.describe ArmySelectorComponent, type: :helper do
  include ViewComponent::TestHelpers

  let(:game_system) { create(:wargame) }
  let(:user) { create(:user) }
  let(:team_user) { create(:user) }
  let(:team) { create(:team, users: [team_user]) }
  let(:army) { create(:army, game_system:) }
  let(:game) { create(:game, game_system:) }
  let(:army_list) { create(:army_list, army:, user:, game_system:) }
  let(:current_player) { create(:player, :with_user, game:) }
  let(:player_team) { create(:player, game:, controller: team) }

  describe "player user" do
    before do
      allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user)
      form_with model: game do |player_form|
        render_inline(described_class.new(game:, player_form:, current_player:, player_index: 0))
      end
    end

    it "should have a btn" do
      expect(page).to have_css(".btn")
    end
  end
  describe "player team" do
    before do
      allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(team_user)
      form_with model: game do |player_form|
        render_inline(described_class.new(game:, player_form:, current_player: player_team, player_index: 1))
      end
    end

    it "should have a btn" do
      expect(page).to have_css(".btn")
    end
  end
end
