class Player < ApplicationRecord
  belongs_to :game
  belongs_to :controller, polymorphic: true

  delegate :display_name, to: :controller

  store_accessor :game_data, :turns

  after_create(:setup_game_data)

  def setup_game_data
    self.game_data = game.game_system.setup_player_data
    save!
  end

  def calculate_score
    score = 0
    system = game.game_system
    if system.has_turns?
      scoring_keys = system.scoring_values
      turns.each do |turn|
        scoring_keys.each do |key|
          score += turn[key]
        end
      end
    end
    score
  end
end
