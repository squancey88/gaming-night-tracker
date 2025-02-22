class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy add_xp_gain_applied_row add_unit_applied_modifier_row]
  before_action :set_user_player, only: %i[show add_xp_gain_applied_row add_unit_applied_modifier_row]

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    session = @game.gaming_session
    @game.destroy!

    respond_to do |format|
      format.html { redirect_to gaming_group_gaming_session_url(session.gaming_group, session), notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_xp_gain_applied_row
    helpers.fields Game.new do |game_form|
      game_form.fields_for :unit_xp_gain_applied, UnitXpGainApplied.new(game: @game), child_index: Time.now.to_i do |f|
        render turbo_stream: turbo_stream.append(
          :xp_gain_applied_row,
          partial: "unit_xp_gain_applied/form_row",
          locals: {form: f, game_system: @game.game_system, game: @game, user_player: @current_user_player}
        )
      end
    end
  end

  def add_unit_applied_modifier_row
    helpers.fields Game.new do |game_form|
      game_form.fields_for :unit_applied_modifier, UnitAppliedModifier.new(game: @game), child_index: Time.now.to_i do |f|
        render turbo_stream: turbo_stream.append(
          :unit_applied_modifier_row,
          partial: "unit_applied_modifier/form_row",
          locals: {form: f, game_system: @game.game_system, game: @game, user_player: @current_user_player}
        )
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  def set_user_player
    @current_user_player = @game.players.filter { _1.user_is_player?(current_user) }&.first
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(
      :gaming_session_id, :game_system_id, :campaign_id,
      :game_state, :finish_reason,
      players_attributes: [:id, :controller_id, :controller_type, :notes, :surrendered,
        player_armies_attributes: [:id, :army_id, :army_list_id, :_destroy],
        game_data: {}],
      unit_xp_gain_applied_attributes: [:id, :unit_id, :unit_xp_gain_event_id],
      unit_applied_modifier_attributes: [:id, :unit_id, :unit_stat_modifier_id]
    )
  end
end
