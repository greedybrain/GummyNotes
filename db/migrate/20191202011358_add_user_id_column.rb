class AddUserIdColumn < ActiveRecord::Migration[4.2]
  
  def change
    add_column :gummy_notes, :user_id, :integer
  end

end
