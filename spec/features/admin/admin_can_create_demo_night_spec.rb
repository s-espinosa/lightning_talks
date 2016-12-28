require 'rails_helper'

describe "when an admin logs in" do
  it "they can create a new demo night" do
    admin = create(:admin, uid: 98765)
    demo  = create(:demo_night, status: 'closed')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_demo_nights_path
    within('.closed-demo-nights') do
      expect(page).to have_content(demo.name)
    end

    within('.active-demo-night') do
      click_link "Create New Demo Night"
    end
    fill_in "Name", with: "Demo Night - 1611"
    click_button "Create Demo Night!"

    expect(current_path).to eq("/admin/demo_nights/#{DemoNight.last.id}")
    within('.projects') do
      expect(page).to have_content("No Projects Yet!")
    end

    within('.admin-tools') do
      expect(page).to have_link('Open voting!')
    end
  end
end
