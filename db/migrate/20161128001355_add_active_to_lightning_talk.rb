class AddActiveToLightningTalk < ActiveRecord::Migration[5.0]
  def change
    add_column :lightning_talks, :active, :boolean, default: false
  end
end
