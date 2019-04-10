require 'rails_helper'

describe 'When a user visits the new project path', js: true do
  it 'they can create a new project' do
    create(:lightning_talk_with_projects)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_project_path
    fill_in "project[group_members]", with: "Sharon Jones"
    fill_in "project[name]", with: "Witty Name"
    fill_in "project[note]", with: "Please put me last"
    find('div.select-wrapper.modules input').click
    find('div.select-wrapper li', text: 'BE Mod 3').click
    find('div.select-wrapper.weeks input').click
    find('div.select-wrapper li', text: 'Week 3').click
    click_on "Submit"

    new_project      = Project.last
    existing_project = Project.first
    expect(current_path).to eq(projects_path)
    expect(page).to have_content("Talk successfully submitted!")
    within('.unvoted') do
      expect(page).to have_content("Witty Name")
      expect(page).to have_content("Sharon Jones")
      expect(page).to have_content("Week 3")
      expect(page).to have_link("Edit Talk", href: edit_project_path(new_project))
      expect(page).to_not have_link("Edit Talk", href: edit_project_path(existing_project))
      expect(page).to_not have_link("Vote")
    end
  end
end
