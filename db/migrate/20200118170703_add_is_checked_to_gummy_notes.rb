class AddIsCheckedToGummyNotes < ActiveRecord::Migration
  
  def change
    add_column :gummy_notes, :is_checked, :boolean, default: false
  end

end
