module Helper

     def self.logged_in?(session)
          !!session[:username]
     end

     def self.current_user(session)
          User.find_by(username: session[:username])
     end

end