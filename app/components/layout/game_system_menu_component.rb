# frozen_string_literal: true

class Layout::GameSystemMenuComponent < ViewComponent::Base
  def initialize(game_system:)
    @game_system = game_system
  end

  def render?
    @game_system
  end
end
