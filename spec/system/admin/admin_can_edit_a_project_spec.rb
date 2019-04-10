require 'rails_helper'

describe 'When an admin visits the admin lightning talk show path' do
  it 'they can click on a link to edit a project' do
    admin = create(:admin, uid: 123456)
    lightning_talk = create(:lightning_talk_with_projects)
    project1 = lightning_talk.projects.first
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_lightning_talk_path(lightning_talk)
    click_link('Edit', href: edit_admin_project_path(project1))
    fill_in('project[name]', with: "New Name")
    click_on('Submit')

    expect(page).not_to have_content(project1.name)
    expect(page).to have_content("New Name")
    expect(page).to have_link('Other talks from this Lightning Talk', href: admin_lightning_talk_path(lightning_talk))
  end
end
