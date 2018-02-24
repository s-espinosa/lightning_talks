require 'rails_helper'

describe "When a user votes on a project" do
  it "they can only vote on a project once" do
    lightning_talk = create(:lightning_talk_with_projects, status: 'voting')
    project1, project2 =  lightning_talk.projects

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/lightning_talks/#{lightning_talk.id}/projects"
    within ('.unvoted') do
      expect(page).to have_content(project1.name)
      expect(page).to have_content(project2.name)
    end

    click_link('Rate', href: new_project_vote_path(project1))
    select "3", from: "vote[representation]"
    select "3", from: "vote[challenge]"
    select "3", from: "vote[wow]"
    click_button("Submit")
    expect(current_path).to eq("/lightning_talks/#{lightning_talk.id}/projects")
    within ('.unvoted') do
      expect(page).to_not have_content(project1.name)
    end

    within ('.voted') do
      expect(page).to have_content(project1.name)
    end
  end
end
