require "rails_helper"

describe "on updating status of demo night", js: true  do
  before do
    admin  = create(:admin)
    @active = create(:demo_night)
    closed = create(:demo_night, status: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  it "only allows one active demo night - from index" do
    visit admin_demo_nights_path
    within('.closed-demo-nights') do
      click_link("open voting")
    end
    expect(page).to have_content("There can only be 1 active demo night at a time")
  end

  it "allows active demo night to be closed" do
    visit admin_demo_nights_path
    within('.active-demo-night') do
      click_link("closed")
    end
    
    @active.reload
    expect(page).to have_content("#{@active.name} now #{@active.status.humanize.downcase}")
  end
end
