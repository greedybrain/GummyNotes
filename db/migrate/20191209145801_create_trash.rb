class CreateTrash < ActiveRecord::Migration[5.2]
  
  def change
    create_table :trashes do |t|
      t.integer :note_id
      t.integer :user_id
    end
  end

end
