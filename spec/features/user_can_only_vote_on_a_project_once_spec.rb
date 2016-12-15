require 'rails_helper'

describe "When a user votes on a project" do
  it "they can only vote on a project once" do
    demo_night = create(:demo_night_with_projects)
    project1, project2 =  demo_night.projects

    
  end
end
