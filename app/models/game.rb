class Game < ApplicationRecord
  belongs_to :gaming_session, dependent: nil
  belongs_to :game_system, dependent: nil
  belongs_to :campaign, dependent: nil, optional: true

  has_many :players, dependent: :destroy
  has_many :unit_xp_gain_applied, dependent: :destroy
  has_many :unit_applied_modifier, dependent: :destroy

  enum game_state: {not_played: 0, in_progress: 3, finished: 2, cancelled: 1}

  validates :players, presence: true

  accepts_nested_attributes_for :players
  accepts_nested_attributes_for :unit_xp_gain_applied
  accepts_nested_attributes_for :unit_applied_modifier

  before_create(:setup_data)
  after_save(:check_finished)

  def set_initial_data(**start_values)
    @initial_data = start_values
  end

  def setup_data
    game_data = game_system.setup_game_data
    game_data.merge!(@initial_data) if @initial_data
    self.data = game_data
  end

  def check_finished
    if finished?
      set_winners
    else
      players.each { |p| p.update_column(:result, :not_set) }
    end
  end

  def editable?
    finished? || cancelled?
  end

  def winners
    players.where(result: :won)
  end

  def set_winners
    game_system.set_winners(self)
  end
end
