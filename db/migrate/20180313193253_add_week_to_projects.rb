class AddWeekToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :week, :string
  end
end
