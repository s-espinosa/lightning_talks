class AddActiveToDemoNight < ActiveRecord::Migration[5.0]
  def change
    add_column :demo_nights, :active, :boolean, default: false
  end
end
