class UnitTraitCategory < ApplicationRecord
  belongs_to :game_system

  validates :name, presence: true

  def to_s = name
end
