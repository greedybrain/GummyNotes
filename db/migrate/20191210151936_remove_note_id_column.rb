class RemoveNoteIdColumn < ActiveRecord::Migration[5.2]
  
  def change
    remove_column :trashes, :note_id, :integer
  end

end
