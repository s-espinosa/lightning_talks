class CreateLightningTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :lightning_talks do |t|
      t.string :name
    end
  end
end
