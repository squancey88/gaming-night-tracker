require "rails_helper"

RSpec.describe "/unit_stat_modifiers", type: :request do
  let(:game_system) { create(:wargame) }
  let!(:unit_stat_modifier) { create(:unit_stat_modifier, game_system:) }
  let(:user) { create(:user) }

  let(:valid_attributes) {
    {
      game_system_id: game_system.id,
      name: Faker::Lorem.sentence
    }
  }

  let(:invalid_attributes) {
    {
      game_system_id: nil,
      name: Faker::Lorem.sentence
    }
  }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      get unit_stat_modifiers_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get unit_stat_modifier_url(unit_stat_modifier)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_unit_stat_modifier_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_unit_stat_modifier_url(unit_stat_modifier)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UnitStatModifier" do
        expect {
          post unit_stat_modifiers_url, params: {unit_stat_modifier: valid_attributes}
        }.to change(UnitStatModifier, :count).by(1)
      end

      it "redirects to the created unit_stat_modifier" do
        post unit_stat_modifiers_url, params: {unit_stat_modifier: valid_attributes}
        expect(response).to redirect_to(unit_stat_modifier_url(UnitStatModifier.order(:created_at).last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UnitStatModifier" do
        expect {
          post unit_stat_modifiers_url, params: {unit_stat_modifier: invalid_attributes}
        }.to change(UnitStatModifier, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post unit_stat_modifiers_url, params: {unit_stat_modifier: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_name) { "New Name" }
      let(:new_attributes) {
        {name: new_name}
      }

      it "updates the requested unit_stat_modifier" do
        patch unit_stat_modifier_url(unit_stat_modifier), params: {unit_stat_modifier: new_attributes}
        unit_stat_modifier.reload
        expect(unit_stat_modifier.name).to eq(new_name)
      end

      it "redirects to the unit_stat_modifier" do
        patch unit_stat_modifier_url(unit_stat_modifier), params: {unit_stat_modifier: new_attributes}
        unit_stat_modifier.reload
        expect(response).to redirect_to(unit_stat_modifier_url(unit_stat_modifier))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch unit_stat_modifier_url(unit_stat_modifier), params: {unit_stat_modifier: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested unit_stat_modifier" do
      expect {
        delete unit_stat_modifier_url(unit_stat_modifier)
      }.to change(UnitStatModifier, :count).by(-1)
    end

    it "redirects to the unit_stat_modifiers list" do
      delete unit_stat_modifier_url(unit_stat_modifier)
      expect(response).to redirect_to(unit_stat_modifiers_url)
    end
  end
end
