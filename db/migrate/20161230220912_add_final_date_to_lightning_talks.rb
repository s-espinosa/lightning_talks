class AddFinalDateToLightningTalks < ActiveRecord::Migration[5.0]
  def change
    add_column :lightning_talks, :final_date, :date
  end
end
