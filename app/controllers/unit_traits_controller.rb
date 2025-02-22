class UnitTraitsController < ApplicationController
  include GameSystemPart
  before_action :set_unit_trait, only: %i[show edit update destroy]

  # GET /unit_traits or /unit_traits.json
  def index
  end

  # GET /unit_traits/1 or /unit_traits/1.json
  def show
  end

  # GET /unit_traits/new
  def new
    @unit_trait.active = true
  end

  # GET /unit_traits/1/edit
  def edit
  end

  # POST /unit_traits or /unit_traits.json
  def create
    @unit_trait = UnitTrait.new(unit_trait_params)

    respond_to do |format|
      if @unit_trait.save
        format.html { redirect_to game_systems_wargame_url(@unit_trait.game_system), notice: "Unit trait was successfully created." }
        format.json { render :show, status: :created, location: @unit_trait }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_traits/1 or /unit_traits/1.json
  def update
    respond_to do |format|
      if @unit_trait.update(unit_trait_params)
        format.html { redirect_to game_systems_wargame_url(@unit_trait.game_system), notice: "Unit trait was successfully updated." }
        format.json { render :show, status: :ok, location: @unit_trait }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_traits/1 or /unit_traits/1.json
  def destroy
    @unit_trait.destroy!

    respond_to do |format|
      format.html { redirect_to unit_traits_url, notice: "Unit trait was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_unit_trait
    @unit_trait = UnitTrait.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def unit_trait_params
    params.require(:unit_trait).permit(:name, :description, :game_system_id, :army_id, :active, :rich_description,
      unit_trait_category_mappings_attributes: [:unit_trait_category_id, :order, :_destroy, :id])
  end
end
