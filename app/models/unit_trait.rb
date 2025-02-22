class UnitTrait < ApplicationRecord
  include Activatable

  belongs_to :game_system
  belongs_to :army, optional: true
  has_many :unit_trait_mappings, dependent: :destroy
  has_many :unit_trait_category_mappings, dependent: :destroy, foreign_key: :mapped_to_id, inverse_of: :mapped_to
  has_many :unit_trait_categories, through: :unit_trait_category_mappings

  validates :name, presence: true

  accepts_nested_attributes_for :unit_trait_category_mappings, allow_destroy: true

  def to_s = name
end
