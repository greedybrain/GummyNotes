class RemoveNoteIdColumn < ActiveRecord::Migration[4.2]
  
  def change
    remove_column :trashes, :note_id, :integer
  end

end
