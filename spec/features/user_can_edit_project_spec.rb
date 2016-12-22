require 'rails_helper'

describe 'A user edits a project' do
  before do
    create(:demo_night_with_projects)
    @user      = User.last
    @project   = Project.last
    @demonight = DemoNight.last
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'lets a user edit a project within a demo night that is accepting submissions' do
    visit projects_path
    click_link('Edit Project')
    fill_in "project[name]", with: "Mark Miranda Pushes Code"
    click_on "Submit"

    expect(current_path).to eq(project_path(@project))
    expect(page).to have_content("Mark Miranda Pushes Code")
    expect(page).to_not have_content(@project.name)
	end

  it 'edit project - sad path', js: true do
    visit projects_path
    click_link('Edit Project')
    fill_in "project[name]", with: ""
    click_on "Submit"

    expect(page).to have_content("Something went wrong!")
	end

  it 'does not let a user edit a project if demo night is voting or closed' do
    @demonight.update(status: "voting")
    visit projects_path
    expect(page).to_not have_link("Edit Project")
  end

end
