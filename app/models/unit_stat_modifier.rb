class UnitStatModifier < ApplicationRecord
  include Activatable

  belongs_to :game_system
  has_many :unit_stat_changes, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :unit_stat_changes, allow_destroy: true, reject_if: proc { |attributes| attributes["stat_change"].blank? }

  def to_s = name
end
