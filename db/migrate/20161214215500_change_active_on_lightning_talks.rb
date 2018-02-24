class ChangeActiveOnLightningTalks < ActiveRecord::Migration[5.0]
  def change
    change_table :lightning_talks do |t|
      t.remove :active
      t.integer :status, default: 0
    end
  end
end
