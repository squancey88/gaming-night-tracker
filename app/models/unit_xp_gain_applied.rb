class UnitXpGainApplied < ApplicationRecord
  belongs_to :game
  belongs_to :unit
  belongs_to :unit_xp_gain_event
end
