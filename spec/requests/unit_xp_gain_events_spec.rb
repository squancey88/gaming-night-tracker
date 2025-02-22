require "rails_helper"

RSpec.describe "/unit_xp_gain_events", type: :request do
  let(:game_system) { create(:wargame) }
  let(:user) { create(:user) }
  let!(:unit_xp_gain_event) { create(:unit_xp_gain_event, game_system:) }

  let(:valid_attributes) {
    {
      game_system_id: game_system.id,
      xp_gain: 2,
      name: "Test"
    }
  }

  let(:invalid_attributes) {
    {
      xp_gain: nil,
      name: nil
    }
  }

  before do
    sign_in(user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      get unit_xp_gain_events_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get unit_xp_gain_event_url(unit_xp_gain_event)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_unit_xp_gain_event_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_unit_xp_gain_event_url(unit_xp_gain_event)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UnitXpGainEvent" do
        expect {
          post unit_xp_gain_events_url, params: {unit_xp_gain_event: valid_attributes}
        }.to change(UnitXpGainEvent, :count).by(1)
      end

      it "redirects to the created unit_xp_gain_event" do
        post unit_xp_gain_events_url, params: {unit_xp_gain_event: valid_attributes}
        expect(response).to redirect_to(unit_xp_gain_event_url(UnitXpGainEvent.order(:created_at).last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UnitXpGainEvent" do
        expect {
          post unit_xp_gain_events_url, params: {unit_xp_gain_event: invalid_attributes}
        }.to change(UnitXpGainEvent, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post unit_xp_gain_events_url, params: {unit_xp_gain_event: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "New name"
        }
      }

      it "updates the requested unit_xp_gain_event" do
        unit_xp_gain_event = UnitXpGainEvent.create! valid_attributes
        patch unit_xp_gain_event_url(unit_xp_gain_event), params: {unit_xp_gain_event: new_attributes}
        unit_xp_gain_event.reload
        expect(unit_xp_gain_event.name).to eq("New name")
      end

      it "redirects to the unit_xp_gain_event" do
        patch unit_xp_gain_event_url(unit_xp_gain_event), params: {unit_xp_gain_event: new_attributes}
        unit_xp_gain_event.reload
        expect(response).to redirect_to(unit_xp_gain_event_url(unit_xp_gain_event))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch unit_xp_gain_event_url(unit_xp_gain_event), params: {unit_xp_gain_event: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested unit_xp_gain_event" do
      expect {
        delete unit_xp_gain_event_url(unit_xp_gain_event)
      }.to change(UnitXpGainEvent, :count).by(-1)
    end

    it "redirects to the unit_xp_gain_events list" do
      delete unit_xp_gain_event_url(unit_xp_gain_event)
      expect(response).to redirect_to(unit_xp_gain_events_url)
    end
  end
end
