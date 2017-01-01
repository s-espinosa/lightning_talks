require 'rails_helper'

describe "When an admin visits the admin projects path" do
  xit "they see a list of projects" do
    admin = create(:admin, uid: 123456)
    project = create(:project)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_demo_nights_path
    within('.hide-on-med-and-down') do
      click_on "Current Projects"
    end

    expect(current_path).to eq(admin_projects_path)
    expect(page).to have_content(project.name)
  end
end
