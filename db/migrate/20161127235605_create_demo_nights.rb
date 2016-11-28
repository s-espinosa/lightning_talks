class CreateDemoNights < ActiveRecord::Migration[5.0]
  def change
    create_table :demo_nights do |t|
      t.string :name
    end
  end
end
