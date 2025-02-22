class UnitXpGainEventsController < ApplicationController
  include GameSystemPart

  before_action :set_unit_xp_gain_event, only: %i[show edit update destroy]

  # GET /unit_xp_gain_events or /unit_xp_gain_events.json
  def index
  end

  # GET /unit_xp_gain_events/1 or /unit_xp_gain_events/1.json
  def show
  end

  # GET /unit_xp_gain_events/new
  def new
    @unit_xp_gain_event.active = true
  end

  # GET /unit_xp_gain_events/1/edit
  def edit
  end

  # POST /unit_xp_gain_events or /unit_xp_gain_events.json
  def create
    @unit_xp_gain_event = UnitXpGainEvent.new(unit_xp_gain_event_params)

    respond_to do |format|
      if @unit_xp_gain_event.save
        format.html { redirect_to unit_xp_gain_event_url(@unit_xp_gain_event), notice: "Unit xp gain method was successfully created." }
        format.json { render :show, status: :created, location: @unit_xp_gain_event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unit_xp_gain_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_xp_gain_events/1 or /unit_xp_gain_events/1.json
  def update
    respond_to do |format|
      if @unit_xp_gain_event.update(unit_xp_gain_event_params)
        format.html { redirect_to unit_xp_gain_event_url(@unit_xp_gain_event), notice: "Unit xp gain method was successfully updated." }
        format.json { render :show, status: :ok, location: @unit_xp_gain_event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unit_xp_gain_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_xp_gain_events/1 or /unit_xp_gain_events/1.json
  def destroy
    @unit_xp_gain_event.destroy!

    respond_to do |format|
      format.html { redirect_to unit_xp_gain_events_url, notice: "Unit xp gain method was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_unit_xp_gain_event
    @unit_xp_gain_event = UnitXpGainEvent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def unit_xp_gain_event_params
    params.require(:unit_xp_gain_event).permit(:name, :description, :xp_gain, :game_system_id, :active)
  end
end
