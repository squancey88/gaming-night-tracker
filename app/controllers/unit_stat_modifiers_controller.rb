class UnitStatModifiersController < ApplicationController
  include GameSystemPart

  before_action :set_unit_stat_modifier, only: %i[show edit update destroy]

  # GET /unit_stat_modifiers or /unit_stat_modifiers.json
  def index
  end

  # GET /unit_stat_modifiers/1 or /unit_stat_modifiers/1.json
  def show
  end

  # GET /unit_stat_modifiers/new
  def new
  end

  # GET /unit_stat_modifiers/1/edit
  def edit
  end

  # POST /unit_stat_modifiers or /unit_stat_modifiers.json
  def create
    @unit_stat_modifier = UnitStatModifier.new(unit_stat_modifier_params)

    respond_to do |format|
      if @unit_stat_modifier.save
        format.html { redirect_to unit_stat_modifier_url(@unit_stat_modifier), notice: "Unit stat modifier was successfully created." }
        format.json { render :show, status: :created, location: @unit_stat_modifier }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit_stat_modifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_stat_modifiers/1 or /unit_stat_modifiers/1.json
  def update
    respond_to do |format|
      if @unit_stat_modifier.update(unit_stat_modifier_params)
        format.html { redirect_to unit_stat_modifier_url(@unit_stat_modifier), notice: "Unit stat modifier was successfully updated." }
        format.json { render :show, status: :ok, location: @unit_stat_modifier }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit_stat_modifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_stat_modifiers/1 or /unit_stat_modifiers/1.json
  def destroy
    @unit_stat_modifier.destroy!

    respond_to do |format|
      format.html { redirect_to unit_stat_modifiers_url, notice: "Unit stat modifier was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_stat_change_row
    helpers.fields UnitStatModifier.new do |f|
      f.fields_for :unit_stat_changes, UnitStatChange.new, child_index: Time.now.to_i do |ff|
        render turbo_stream: turbo_stream.append(
          "stat_change_list",
          partial: "unit_stat_changes/form_row",
          locals: {form: ff, game_system: @game_system}
        )
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_unit_stat_modifier
    @unit_stat_modifier = UnitStatModifier.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def unit_stat_modifier_params
    params.require(:unit_stat_modifier).permit(:game_system_id, :cost, :active, :name, :rich_description,
      unit_stat_changes_attributes: [:id, :stat_change, :unit_stat_definition_id])
  end
end
