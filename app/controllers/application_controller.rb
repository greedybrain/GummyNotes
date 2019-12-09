require_relative "../models/user"
require_relative "../models/gummy_note"


class ApplicationController < Sinatra::Base

    configure do 
        set :views, "app/views"
        enable(:sessions)
        set(:session_secret, "s7y7n7t7a7x7t7i7c")
    end

    # HOME PAGE SIGNUP/LOGIN/ETC

    get "/" do 
        if logged_in?
            redirect "/account/home"
        else
            erb :index # renders signup/login page
        end
    end

    # END OF SIGN UP/LOGIN HOMEPAGE ETC ==========

    # CREATE USER AREA

    get "/signup" do 
        erb :'/registrations/signup'
    end

    post "/signup" do 
        if user_already_exists? || email_already_exists?
            erb :'/registrations/signup'
        else
            user = User.create(name: params[:name], username: params[:username].downcase, email: params[:email].downcase, password: params[:password])

            if user
                session[:username] = user.username
                redirect "/account/home"
            else
                redirect '/'
            end 
        end
    end

    # END OF CREATE USER AREA ==========

    # "SHOW" AREA

    get "/login" do 
        if logged_in?
            redirect '/account/home'
        else
            erb(:'/sessions/login')
        end
    end

    post "/login" do 
        @user = User.find_by(username: params[:username].downcase)
        
        if @user && @user.authenticate(params[:password])
            session[:username] = @user.username
            redirect '/account/home'
        else
            @fail_msg = could_not_find_user
            @fail_styles = "color: red; background-color: #fff; border-radius: 5px; margin-bottom: 10px; padding: 10px 0; font-size: 0.8rem"
            erb :'/sessions/login'
        end
    end

    get "/account/home" do
        if logged_in?
            erb :'/users/account_home'
        else
            redirect "/"
        end
    end

    # END OF "SHOW" AREA ==========

    # "DESTROY" AREA

    get "/logout" do 
        session.clear 
        redirect "/login"
    end

    # END OF "DESTROY" AREA ==========
    
    # HELPER METHODS ==========

    helpers do
        def logged_in?
            !!session[:username]
        end

        def current_user
            User.find_by(username: session[:username])
        end

        def user_already_exists? 
            User.all.collect{|user| user.username}.include?(params[:username])
        end

        def email_already_exists? 
            User.all.collect{|user| user.email}.include?(params[:email])
        end

        def could_not_find_user
            "Account doesn't exist, check your username and/or password"
        end

    end

end
