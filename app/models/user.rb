class User < ActiveRecord::Base 

    has_secure_password

    validates_uniqueness_of :username, :email
    validates :name, :username, :email, :password,  :presence => true
    validates :password, :length => { :minimum => 8 }

    has_many :gummy_notes
    has_one :trash

end
