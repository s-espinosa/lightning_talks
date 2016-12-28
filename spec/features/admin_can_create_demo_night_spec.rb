require 'rails_helper'

describe "when an admin logs in" do
  it "they can create a new demo night" do
    admin = create(:admin, uid: 98765)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_dashboard_path

    click_link "Create New Demo Night"
    fill_in "Name", with: "Demo Night - 1611"
    click_button "Create Demo Night!"

    expect(current_path).to eq("/admin/demo_nights/#{DemoNight.last.id}")
    within('.projects') do
      expect(page).to have_content("No Projects Yet!")
    end

    within('.admin-tools') do
      expect(page).to have_link('open voting')
    end
  end
end
