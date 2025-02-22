require "rails_helper"

RSpec.describe "/unit_trait_categories", type: :request do
  let(:user) { create(:user) }
  let(:game_system) { create(:wargame) }
  let!(:unit_trait_category) { create(:unit_trait_category, game_system:) }
  let(:valid_attributes) {
    {
      name: Faker::Lorem.word,
      game_system_id: game_system.id
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      game_system_id: game_system.id
    }
  }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      get unit_trait_categories_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get unit_trait_category_url(unit_trait_category)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_unit_trait_category_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UnitTrait" do
        expect {
          post unit_trait_categories_url, params: {unit_trait_category: valid_attributes}
        }.to change(UnitTraitCategory, :count).by(1)
      end

      it "redirects to the created unit_trait" do
        post unit_trait_categories_url, params: {unit_trait_category: valid_attributes}
        expect(response).to redirect_to(unit_trait_category_url(UnitTraitCategory.order(:created_at).last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UnitTrait" do
        expect {
          post unit_trait_categories_url, params: {unit_trait_category: invalid_attributes}
        }.to change(UnitTraitCategory, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post unit_trait_categories_url, params: {unit_trait_category: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {name: "New name"}
      }

      it "updates the requested unit_trait" do
        patch unit_trait_category_url(unit_trait_category), params: {unit_trait_category: new_attributes}
        unit_trait_category.reload
        expect(unit_trait_category.name).to eq "New name"
      end

      it "redirects to the unit_trait_category" do
        patch unit_trait_category_url(unit_trait_category), params: {unit_trait_category: new_attributes}
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch unit_trait_category_url(unit_trait_category), params: {unit_trait_category: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested unit_trait" do
      expect {
        delete unit_trait_category_url(unit_trait_category)
      }.to change(UnitTraitCategory, :count).by(-1)
    end

    it "redirects to the unit_trait_categories list" do
      delete unit_trait_category_url(unit_trait_category)
      expect(response).to redirect_to(root_url)
    end
  end
end
