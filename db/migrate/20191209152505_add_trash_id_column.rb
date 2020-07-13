class AddTrashIdColumn < ActiveRecord::Migration
  
  def change
    add_column :gummy_notes, :trash_id, :integer
  end

end
