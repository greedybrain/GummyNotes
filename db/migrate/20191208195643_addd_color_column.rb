class AdddColorColumn < ActiveRecord::Migration

  def change
    add_column :gummy_notes, :color, :string
  end

end
