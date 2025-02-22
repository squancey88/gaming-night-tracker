RSpec.shared_examples "game system form" do
  it "should include hidden game system id" do
    render
    expect(rendered).to have_css("input[name*='[game_system_id]']", visible: false)
  end
end
