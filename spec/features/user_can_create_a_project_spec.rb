require 'rails_helper'

describe 'When a user visits the new project path', js: true do
  it 'they can create a new project' do
    create(:demo_night)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_project_path
    fill_in "project[group_members]", with: "Sharon Jones"
    fill_in "project[name]", with: "Witty Name"
    find('div.select-wrapper input').click
    find('div.select-wrapper li', text: 'BE Mod 3').click
    find('label', text: 'Are you able to present at the Demo Night Finals?').click
    click_on "Submit"

    project = Project.last
    expect(current_path).to eq(project_path(project))
    expect(page).to have_content("Project successfully submitted!")
    expect(page).to have_content("Witty Name")
    expect(page).to have_content("Sharon Jones")
    expect(page).to have_content("Able to Present at Final Demo Night: true")
  end
end
