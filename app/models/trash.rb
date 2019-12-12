class Trash < ActiveRecord::Base 

    has_many :gummy_notes
    belongs_to :user 

end