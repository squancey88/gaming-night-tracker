class UnitsController < ApplicationController
  before_action :set_army_list
  before_action :set_game_system, only: %i[add_trait_row]
  before_action :set_unit, only: %i[show edit update destroy]

  # GET /units or /units.json
  def index
    @units = @army_list.units
  end

  # GET /units/1 or /units/1.json
  def show
  end

  # GET /units/new
  def new
    if from_template_params[:template_id]
      begin
        @unit = UnitTemplate.find(from_template_params[:template_id]).to_unit(@army_list)
      rescue ActiveRecord::RecordNotFound
        @unit = Unit.new_with_stats(@army_list)
        flash[:alert] = "Unable to find template"
      end
    else
      @unit = Unit.new_with_stats(@army_list)
      begin
        @unit.clone_from(clone_params[:cloned_from_id]) if clone_params[:cloned_from_id]
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Unable to find unit to clone from"
      end
    end
  end

  # GET /units/1/edit
  def edit
    all_defs = @unit.unit_stats.collect(&:unit_stat_definition)
    diff_defs = @army_list.game_system.unit_stat_definitions - all_defs
    diff_defs.each do |definition|
      @unit.unit_stats.build(unit_stat_definition: definition)
    end
  end

  # POST /units or /units.json
  def create
    @unit = @army_list.units.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to army_list_url(@army_list), notice: "Unit was successfully created." }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1 or /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to army_list_url(@army_list), notice: "Unit was successfully updated." }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1 or /units/1.json
  def destroy
    @unit.destroy!

    respond_to do |format|
      format.html { redirect_to army_list_url(@army_list), notice: "Unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_trait_row
    helpers.fields Unit.new do |f|
      f.fields_for :unit_trait_mappings, UnitTraitMapping.new, child_index: Time.now.to_i do |ff|
        render turbo_stream: turbo_stream.append(
          :trait_mappings,
          partial: "unit_traits/mapping_row",
          locals: {form: ff, game_system: @game_system}
        )
      end
    end
  end

  private

  def set_game_system
    @game_system = GameSystem.find(params[:game_system_id])
  end

  def set_army_list
    @army_list = ArmyList.find(params[:army_list_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_unit
    @unit = Unit.find(params[:id])
  end

  def clone_params
    params.permit(:cloned_from_id)
  end

  def from_template_params
    params.permit(:template_id)
  end

  # Only allow a list of trusted parameters through.
  def unit_params
    params.require(:unit).permit(:name, :description, :cost, stats: {},
      unit_stats_attributes: [:id, :base_value, :unit_stat_definition_id],
      unit_trait_mappings_attributes: [:id, :unit_trait_id],
      unit_trait_category_mappings_attributes: [:unit_trait_category_id, :order, :_destroy, :id])
  end
end
