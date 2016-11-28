require 'rails_helper'

describe 'When a user visits the new project path' do
  it 'they can create a new project' do
    create(:demo_night)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_project_path
    fill_in "project[group_members]", with: "Sharon Jones"
    fill_in "project[name]", with: "Witty Name"
    select "BE Mod 3", from: "project[project_type]"
    check "project[final_confirmation]"
    click_on "Submit"

    project = Project.last
    expect(current_path).to eq(project_path(project))
    expect(page).to have_content("Project successfully submitted!")
    expect(page).to have_content("Witty Name")
    expect(page).to have_content("Sharon Jones")
  end
end
