require "rails_helper"

RSpec.describe "/armies", type: :request do
  let(:user) { create(:user) }
  let(:game_system) { create(:wargame) }

  let(:valid_attributes) {
    {
      name: "Test Army",
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
    sign_in(user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      Army.create! valid_attributes
      get armies_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      army = Army.create! valid_attributes
      get army_url(army)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_army_url(game_system_id: game_system.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      army = Army.create! valid_attributes
      get edit_army_url(army)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Army" do
        expect {
          post armies_url, params: {army: valid_attributes}
        }.to change(Army, :count).by(1)
      end

      it "redirects to the created army" do
        post armies_url, params: {army: valid_attributes}
        expect(response).to redirect_to(army_url(Army.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Army" do
        expect {
          post armies_url, params: {army: invalid_attributes}
        }.to change(Army, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post armies_url, params: {army: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "New Name"
        }
      }

      it "updates the requested army" do
        army = Army.create! valid_attributes
        patch army_url(army), params: {army: new_attributes}
        army.reload
        expect(army.name).to eq("New Name")
      end

      it "redirects to the army" do
        army = Army.create! valid_attributes
        patch army_url(army), params: {army: new_attributes}
        army.reload
        expect(response).to redirect_to(game_systems_wargame_url(army.game_system))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        army = Army.create! valid_attributes
        patch army_url(army), params: {army: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested army" do
      army = Army.create! valid_attributes
      expect {
        delete army_url(army)
      }.to change(Army, :count).by(-1)
    end

    it "redirects to the armies list" do
      army = Army.create! valid_attributes
      delete army_url(army)
      expect(response).to redirect_to(game_systems_wargame_url(game_system))
    end
  end
end
