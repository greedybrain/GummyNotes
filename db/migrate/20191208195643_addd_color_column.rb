class AdddColorColumn < ActiveRecord::Migration[4.2]
  
  def change
    add_column :gummy_notes, :color, :string
  end

end
