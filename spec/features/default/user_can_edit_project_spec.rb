require 'rails_helper'

describe 'A user edits a project' do
  before do
    create(:lightning_talk_with_projects)
    @user      = User.last
    @project   = Project.last
    @lightningtalk = LightningTalk.last
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'lets a user edit a project within a lightning talk that is accepting submissions' do
    visit projects_path
    click_link('Edit Talk')
    fill_in "project[name]", with: "Mark Miranda Pushes Code"
    click_on "Submit"

    expect(current_path).to eq(projects_path)
    expect(page).to have_content("Mark Miranda Pushes Code")
    expect(page).to_not have_content(@project.name)
    within('nav') do
      expect(page).to have_link("New Talk")
      expect(page).to have_link("Current Talks")
    end
    within('.unvoted') do
      expect(page).to_not have_link("Vote")
    end
  end

  it 'edit project - sad path', js: true do
    visit projects_path
    click_link('Edit Talk')
    fill_in "project[name]", with: ""
    click_on "Submit"

    expect(page).to have_content("Name can't be blank")
  end

  it 'does not let a user edit a project if lightning talk is voting or closed' do
    @lightningtalk.update(status: "voting")
    visit projects_path
    expect(page).to_not have_link("Edit Talk")
  end
end
