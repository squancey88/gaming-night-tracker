# frozen_string_literal: true

class GameForms::UnitModifiersComponent < ViewComponent::Base
  def initialize(game:, form:, user_player:)
    @game = game
    @form = form
    @user_player = user_player
  end

  def render?
    @user_player
  end
end
