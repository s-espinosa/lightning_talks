require "rails_helper"

describe "when an admin creates a lightning talk", js: true do

  before do
    @lightning_talk = create(:lightning_talk)
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  it "they are redirected to an index page if another lightning talk is active" do
    visit new_admin_lightning_talk_path

    fill_in "Name", with: "Lightning Talk - 1602"
    click_button "Create Lightning Talk!"

    expect(current_path).to eq(admin_lightning_talks_path)
    expect(page).to have_content("There can only be 1 active lightning talk at a time.")
    within('.active-lightning-talk') do
      expect(page).to have_content(@lightning_talk.name.humanize)
    end

  end
end
