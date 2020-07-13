class RemoveNoteIdColumn < ActiveRecord::Migration
  
  def change
    remove_column :trashes, :note_id, :integer
  end

end
