class AddDemoNightToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :demo_night, foreign_key: true
  end
end
