require "rails_helper"

describe "errors 404" do
  it "user tries to access admin pages" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path
    expect(current_path).to eq(errors_404_path)
    expect(page).to have_content("404!")
    expect(page).to have_content("Something weird happened somewhere.")
  end
end
