class RenameVotesColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :votes, :representation, :presentation
    rename_column :votes, :challenge, :content
    rename_column :votes, :wow, :surprise
  end
end
