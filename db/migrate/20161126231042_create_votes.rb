class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.integer :representation
      t.integer :challenge
      t.integer :wow

      t.timestamps null: false
    end
  end
end
