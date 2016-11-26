class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :group_members
      t.string :name
      t.string :project_type
      t.boolean :final_confirmation

      t.timestamps null: false
    end
  end
end
