require "rails_helper"

RSpec.describe "/units", type: :request do
  let(:army_list) { create(:army_list) }
  let(:user) { create(:user) }
  let!(:unit) { create(:unit, army_list:) }

  let(:valid_attributes) {
    {
      name: "New Name",
      army_list:
    }
  }

  let(:invalid_attributes) {
    {
      name: nil
    }
  }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      get army_list_units_url(army_list)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get army_list_unit_url(army_list, unit)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_army_list_unit_url(army_list)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_army_list_unit_url(army_list, unit)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Unit" do
        expect {
          post army_list_units_url(army_list), params: {unit: valid_attributes}
        }.to change(Unit, :count).by(1)
      end

      it "redirects to the created unit" do
        post army_list_units_url(army_list), params: {unit: valid_attributes}
        expect(response).to redirect_to(army_list_url(army_list))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Unit" do
        expect {
          post army_list_units_url(army_list), params: {unit: invalid_attributes}
        }.to change(Unit, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post army_list_units_url(army_list), params: {unit: invalid_attributes}
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

      it "updates the requested unit" do
        patch army_list_unit_url(army_list, unit), params: {unit: new_attributes}
        unit.reload
        expect(unit.name).to eq("New name")
      end

      it "redirects to the unit" do
        patch army_list_unit_url(army_list, unit), params: {unit: new_attributes}
        unit.reload
        expect(response).to redirect_to(army_list_url(army_list))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch army_list_unit_url(army_list, unit), params: {unit: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested unit" do
      expect {
        delete army_list_unit_url(army_list, unit)
      }.to change(Unit, :count).by(-1)
    end

    it "redirects to the units list" do
      delete army_list_unit_url(army_list, unit)
      expect(response).to redirect_to(army_list_url(army_list))
    end
  end
end
