class UnitTemplatesController < ApplicationController
  include GameSystemPart

  before_action :set_unit_template, only: %i[show edit update destroy]

  # GET /unit_templates or /unit_templates.json
  def index
    @unit_templates = @game_system.unit_templates
  end

  # GET /unit_templates/1 or /unit_templates/1.json
  def show
  end

  # GET /unit_templates/new
  def new
  end

  # GET /unit_templates/1/edit
  def edit
    all_defs = @unit_template.unit_template_stats.collect(&:unit_stat_definition)
    diff_defs = @unit_template.game_system.unit_stat_definitions - all_defs
    diff_defs.each do |definition|
      @unit_template.unit_template_stats.build(unit_stat_definition: definition)
    end
  end

  # POST /unit_templates or /unit_templates.json
  def create
    @unit_template = UnitTemplate.new(unit_template_params)

    respond_to do |format|
      if @unit_template.save
        format.html { redirect_to unit_template_url(@unit_template), notice: "Unit template was successfully created." }
        format.json { render :show, status: :created, location: @unit_template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_templates/1 or /unit_templates/1.json
  def update
    respond_to do |format|
      if @unit_template.update(unit_template_params)
        format.html { redirect_to unit_template_url(@unit_template), notice: "Unit template was successfully updated." }
        format.json { render :show, status: :ok, location: @unit_template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_templates/1 or /unit_templates/1.json
  def destroy
    @unit_template.destroy!

    respond_to do |format|
      format.html { redirect_to unit_templates_url, notice: "Unit template was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_trait_row
    helpers.fields UnitTemplate.new do |f|
      f.fields_for :unit_template_trait_mappings, UnitTemplateTraitMapping.new, child_index: Time.now.to_i do |ff|
        render turbo_stream: turbo_stream.append(
          :trait_mappings,
          partial: "unit_traits/mapping_row",
          locals: {form: ff, game_system: @game_system}
        )
      end
    end
  end

  private

  def new_record
    @unit_template = UnitTemplate.new_with_stats(@game_system)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_unit_template
    @unit_template = UnitTemplate.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def unit_template_params
    params.require(:unit_template).permit(:name, :cost, :game_system_id, :army_id,
      unit_template_stats_attributes: [:id, :base_value, :unit_stat_definition_id],
      unit_template_trait_mappings_attributes: [:id, :unit_trait_id],
      unit_trait_category_mappings_attributes: [:unit_trait_category_id, :order, :_destroy, :id])
  end
end
