require "rails_helper"

RSpec.describe "/unit_templates", type: :request do
  let(:game_system) { create(:wargame) }
  let!(:unit_template) { create(:unit_template, game_system:) }
  let(:army) { create(:army, game_system:) }
  let(:user) { create(:user) }

  let(:valid_attributes) {
    {
      name: Faker::Lorem.word,
      army_id: army.id,
      game_system_id: game_system.id
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      army_id: army.id,
      game_system_id: game_system.id
    }
  }

  before do
    sign_in(user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      get unit_templates_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get unit_template_url(unit_template)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_unit_template_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_unit_template_url(unit_template)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UnitTemplate" do
        expect {
          post unit_templates_url, params: {unit_template: valid_attributes}
        }.to change(UnitTemplate, :count).by(1)
      end

      it "redirects to the created unit_template" do
        post unit_templates_url, params: {unit_template: valid_attributes}
        expect(response).to redirect_to(unit_template_url(UnitTemplate.order(:created_at).last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UnitTemplate" do
        expect {
          post unit_templates_url, params: {unit_template: invalid_attributes}
        }.to change(UnitTemplate, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post unit_templates_url, params: {unit_template: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {name: "New name"}
      }

      it "updates the requested unit_template" do
        patch unit_template_url(unit_template), params: {unit_template: new_attributes}
        unit_template.reload
        expect(unit_template.name).to eq "New name"
      end

      it "redirects to the unit_template" do
        patch unit_template_url(unit_template), params: {unit_template: new_attributes}
        unit_template.reload
        expect(response).to redirect_to(unit_template_url(unit_template))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch unit_template_url(unit_template), params: {unit_template: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested unit_template" do
      expect {
        delete unit_template_url(unit_template)
      }.to change(UnitTemplate, :count).by(-1)
    end

    it "redirects to the unit_templates list" do
      delete unit_template_url(unit_template)
      expect(response).to redirect_to(unit_templates_url)
    end
  end
end
