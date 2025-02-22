require "rails_helper"

RSpec.describe "/games", type: :request do
  let(:gaming_session) { create(:gaming_session) }
  let(:game_system) { create(:wargame, :turn_based) }
  let(:new_game_system) { create(:wargame) }
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:valid_attributes) {
    {
      gaming_session_id: gaming_session.id,
      game_system_id: game_system.id,
      players_attributes: [
        {controller_id: user.id, controller_type: "User"},
        {controller_id: user2.id, controller_type: "User"}
      ]
    }
  }

  let(:invalid_attributes) {
    {
      gaming_session_id: nil,
      game_system_id: nil
    }
  }

  before do
    sign_in(user)
    allow_any_instance_of(GamesController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      Game.create! valid_attributes
      get games_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      game = Game.create! valid_attributes
      get game_url(game)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_game_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      game = Game.create! valid_attributes
      get edit_game_url(game)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Game" do
        expect {
          post games_url, params: {game: valid_attributes}
        }.to change(Game, :count).by(1)
      end

      it "redirects to the created game" do
        post games_url, params: {game: valid_attributes}
        expect(response).to redirect_to(Game.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Game" do
        expect {
          post games_url, params: {game: invalid_attributes}
        }.to change(Game, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post games_url, params: {game: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          game_system_id: new_game_system.id
        }
      }

      it "updates the requested game" do
        game = Game.create! valid_attributes
        patch game_url(game), params: {game: new_attributes}
        game.reload
        expect(game.game_system).to eq(new_game_system)
      end

      it "should upate player data" do
        game = Game.create! valid_attributes
        player = game.players.first
        data = [{
          id: player.id,
          game_data: {
            turns: [
              {primary: 5, seconday: 10},
              {primary: 20, seconday: 10}
            ]
          }
        }]
        patch game_url(game), params: {game: {players_attributes: data}}
        player.reload
        expect(player.game_data["turns"].first["primary"]).to eq("5")
        expect(player.game_data["turns"].second["primary"]).to eq("20")
      end

      it "redirects to the game" do
        game = Game.create! valid_attributes
        patch game_url(game), params: {game: new_attributes}
        game.reload
        expect(response).to redirect_to(game_url(game))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        game = Game.create! valid_attributes
        patch game_url(game), params: {game: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested game" do
      game = Game.create! valid_attributes
      expect {
        delete game_url(game)
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      game = Game.create! valid_attributes
      session = game.gaming_session
      delete game_url(game)
      expect(response).to redirect_to(gaming_group_gaming_session_url(session.gaming_group, session))
    end
  end
end
