require "rails_helper"

RSpec.describe GameFormComponent, type: :component do
  let(:game_system) { create(:wargame, :turn_based) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:game) { create(:game, game_system:, user_list: [user1, user2]) }

  before do
    allow_any_instance_of(AuthHelper).to receive(:current_user).and_return(user1)
    render_inline described_class.new(game:)
  end

  it "should render the GameForms::TurnBasedComponent" do
    expect(page).to have_css(".turn-grid")
  end
end
