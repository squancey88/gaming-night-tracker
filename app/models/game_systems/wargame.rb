module GameSystems
  class Wargame < GameSystem
    include HasGameConfig

    has_many :unit_stat_definitions, -> { order "unit_stat_definitions.sort" }, dependent: :destroy,
      foreign_key: "game_system_id", inverse_of: :game_system
    has_many :unit_stat_modifiers, foreign_key: "game_system_id", inverse_of: :game_system, dependent: :destroy
    has_many :unit_templates, dependent: :destroy, foreign_key: "game_system_id", inverse_of: :game_system
    has_many :unit_traits, dependent: :destroy, foreign_key: "game_system_id", inverse_of: :game_system
    has_many :unit_trait_categories, dependent: :destroy, foreign_key: "game_system_id", inverse_of: :game_system
    has_many :equipment, dependent: :destroy, foreign_key: "game_system_id", inverse_of: :game_system
    has_many :unit_xp_gain_events, dependent: :destroy, foreign_key: "game_system_id", inverse_of: :game_system

    accepts_nested_attributes_for :unit_stat_definitions, allow_destroy: true, reject_if: proc { |attributes| attributes["name"].blank? }

    config_has_scoring_systems(:turn_based)
    config_has_turn_data(title: "Turn Tracking",
      point_title: "Tracking Point") do |items|
        items.add_item(:key, :string)
        items.add_item(:type, :string, enum: [:number])
        items.add_item(:name, :string)
        items.add_item(:scoring, :boolean)
      end
    config_has_campaign_list_attributes do |items|
      items.add_item(:key, :string)
      items.add_item(:type, :string, enum: [:number])
      items.add_item(:name, :string)
    end

    def self.category_name
      "Wargames"
    end

    def game_data_form_components(game)
      game_forms = []
      if has_turns?
        game_forms << {
          title: "Turn Details",
          component: GameForms::TurnBasedComponent
        }
      end
      if game.campaign
        game_forms << {
          title: "Unit Modifiers (#{game.campaign.name})",
          component: GameForms::UnitModifiersComponent
        }
        game_forms << {
          title: "Campaign Tracking (#{game.campaign.name})",
          component: GameForms::CampaignAttributesComponent
        }
      end
      game_forms
    end

    def player_form_components
      [
        {
          title: "Your Army",
          component: ArmySelectorComponent
        },
        {
          title: "Your Notes",
          component: PlayerNotesComponent
        }
      ]
    end

    def player_score_by_keys(player)
      score_hash = {}
      if has_turns?
        scoring_keys.each_with_object(score_hash) { |key, hash| hash[key.to_sym] = 0 }
        player.game_data["turns"].each do |turn|
          score_hash.keys.each do |key|
            score_hash[key] = score_hash[key] + turn[key.to_s].to_i
          end
        end
      end
      score_hash
    end

    def calculate_player_score(player)
      score = 0
      if has_turns?
        player.game_data["turns"].each do |turn|
          scoring_keys.each do |key|
            score += turn[key].to_i
          end
        end
      end
      score
    end

    def set_winners(game)
      if has_turns?
        by_score = game.players.map { [_1, _1.calculate_score] }
        if by_score.map { _2 }.uniq.count <= 1
          if game.players.any? { _1.surrendered }
            game.players.each do |p|
              p.result = p.surrendered ? :lost : :won
              p.save!
            end
          else
            game.players.each do |p|
              p.result = :draw
              p.save!
            end
          end
        else
          winning_score = by_score.max_by { _1[1] }[1]
          by_score.each do |player, score|
            player.result = if score == winning_score
              :won
            else
              :lost
            end
            player.save!
          end
        end
      end
    end

    def has_turns?
      scoring_system == "turn_based"
    end

    def scoring_values
      if has_turns?
        turn_data.filter { _1["scoring"] }
      end
    end

    def scoring_keys
      if has_turns?
        scoring_values.pluck("key")
      end
    end

    def setup_player_data(game)
      player_data = {}
      player_data[:turns] = [] if has_turns?
      if game.campaign
        campaign_data = {
          changes: {}
        }
        game.game_system.campaign_list_attributes.each do |attribute|
          campaign_data[:changes][attribute["key"]] = nil
        end
        player_data[:campaign] = campaign_data
      end
      player_data
    end
  end
end
