class ArmyList < ApplicationRecord
  belongs_to :army, optional: true
  belongs_to :user
  belongs_to :game_system
  belongs_to :campaign, optional: true
  has_many :equipment_attachments, dependent: :destroy, foreign_key: "attached_to_id", inverse_of: :attached_to
  has_many :equipment, through: :equipment_attachments

  has_many :units, dependent: :destroy

  before_create :set_initial_values

  validates :name, presence: true

  def set_initial_values
    if campaign
      self.initial_values = campaign.config
      self.starting_cost = campaign.list_start_cost
    end
  end

  def list_cost
    units.sum(:cost) + equipment.sum(:cost)
  end

  def remaining_cost
    return starting_cost - list_cost if starting_cost
    0
  end

  def to_s = name
end
