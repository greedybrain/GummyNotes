class UsersController < ApplicationController 

     # SETTINGS PAGE 
    get "/account/settings" do
        settings_page_or
    end

    # CREATE USER AREA

    get "/signup" do # renders the signup form (new action)
        @user = User.new
        erb :'/users/signup'
    end

    post "/signup" do # once the user is created (create action)
        register_user
    end

    get "/login" do # renders the login form
        show_home
    end

    post "/login" do # user is logged in if the params passed are authentic
        logging_in
    end

    get "/account/home" do # renders users homepage
        show_all_notes
    end

    get "/logout" do # clears the session, then redirects to login page
        logging_out
    end

    # DELETE ACCOUNT PERMANENTLY

    delete "/logout" do # deletes a user permanently 
        delete_account
    end

end