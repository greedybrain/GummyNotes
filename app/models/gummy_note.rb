class GummyNote < ActiveRecord::Base 

    belongs_to :user 
    belongs_to :trash

end
