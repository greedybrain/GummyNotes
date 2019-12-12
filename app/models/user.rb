class User < ActiveRecord::Base 

    has_secure_password
    has_many :gummy_notes
    has_one :trash

end
