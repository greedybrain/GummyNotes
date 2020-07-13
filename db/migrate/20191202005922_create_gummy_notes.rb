class CreateGummyNotes < ActiveRecord::Migration
  
  def change
    create_table :gummy_notes do |t|
      t.string :title
      t.text :content
    end
  end

end
