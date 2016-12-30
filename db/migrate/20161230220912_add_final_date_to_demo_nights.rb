class AddFinalDateToDemoNights < ActiveRecord::Migration[5.0]
  def change
    add_column :demo_nights, :final_date, :date
  end
end
