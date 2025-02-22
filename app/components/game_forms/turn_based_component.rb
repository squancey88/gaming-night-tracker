# frozen_string_literal: true

class GameForms::TurnBasedComponent < ViewComponent::Base
  delegate :players_attributes_form_name,
    :input_field_of_type,
    to: :helpers

  def initialize(game:, form:, user_player:)
    @game = game
    @game_system = @game.game_system
    @turn_count = @game.players.first.turns.length
    @scoring_values = @game_system.scoring_values
  end

  def turn_field_name(player_index, key)
    players_attributes_form_name(player_index, "[game_data][turns][][#{key}]")
  end

  def turn_field(player, player_index, turn_field, turn_index = nil)
    field_name = turn_field_name(player_index, turn_field["key"])
    value = player ? player.turns[turn_index][turn_field["key"]] : nil
    content_tag(:div, class: "form-floating") do
      concat(input_field_of_type(turn_field["type"], field_name, turn_field["name"], value, disabled: @game.editable?))
      concat(label_tag(field_name, turn_field["name"]))
    end
  end
end
