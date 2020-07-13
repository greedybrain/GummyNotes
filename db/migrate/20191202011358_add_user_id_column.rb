class AddUserIdColumn < ActiveRecord::Migration
  
  def change
    add_column :gummy_notes, :user_id, :integer
  end

end
