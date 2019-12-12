class DropTrashCanTable < ActiveRecord::Migration[5.2]
  
  def change
    drop_table :trash_cans
  end

end
