class AddLightningTalkToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :lightning_talk, foreign_key: true
  end
end
