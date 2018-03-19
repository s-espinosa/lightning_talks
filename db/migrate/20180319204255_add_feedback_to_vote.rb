class AddFeedbackToVote < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :feedback, :string
  end
end
