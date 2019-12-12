class AddTrashIdColumn < ActiveRecord::Migration[5.2]
  
  def change
    add_column :gummy_notes, :trash_id, :integer
  end

end
