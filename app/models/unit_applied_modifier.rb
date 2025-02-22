class UnitAppliedModifier < ApplicationRecord
  belongs_to :unit
  belongs_to :game
  belongs_to :unit_stat_modifier
end
