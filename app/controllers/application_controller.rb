class ApplicationController < Sinatra::Base

    configure do 
        set :views, "app/views"
        set :public_folder, "public"
        enable :sessions
        set :session_secret, "s7y7n7t7a7x7t7i7c"
    end

    # HOME PAGE SIGNUP/LOGIN/ETC

    get "/" do 
        if logged_in?
            redirect "/account/home"
        else
            erb :index # renders signup/login page
        end
    end

    # SETTINGS PAGE 
    get "/account/settings" do
        settings_page_or
    end

    # CREATE USER AREA

    get "/signup" do 
        erb :'/registrations/signup'
    end

    post "/signup" do 
        registering_user
    end

    # "SHOW" AREA

    get "/login" do
        show_home
    end

    post "/login" do
        logging_in
    end

    get "/account/home" do
        go_home
    end

    # "DESTROY" AREA

    get "/logout" do
        logging_out
    end

    # DELETE ACCOUNT PERMANENTLY

    delete "/logout" do
        delete_account
    end

    helpers do 

        # USER 

        def logged_in?
            !!session[:username]
        end

        def current_user
            User.find_by(username: session[:username])
        end

        def registering_user
            @user = User.create(name: params[:name], username: params[:username].downcase, email: params[:email].downcase, password: params[:password])
            
            assigned_trash_can(@user)

            if @user
                session[:username] = @user.username
                redirect "/account/home"
            else
                redirect '/'
            end
        end

        def logging_in
            @user = User.find_by(username: params[:username].downcase)
        
            if @user && @user.authenticate(params[:password])
                session[:username] = @user.username
                redirect '/account/home'
            else
                erb :'/sessions/login'
            end
        end

        def show_home
            redirect '/account/home'
        end

        def go_home
            if logged_in?
                erb :"/users/account_home"
            else
                erb :'/sessions/login'
            end
        end

        def settings_page_or
            erb :"/help/settings"
        end

        def logging_out
            session.clear 
            redirect "/login"
        end

        def assigned_trash_can(user) 
            trash_can = Trash.create 
            user.trash = trash_can
            trash_can.user = user
            trash_can
        end

        def delete_account
            user = User.find_by_id(current_user.id)
            session.clear
            user.delete
            user.gummy_notes.delete_all
            redirect "/login"
        end

        # TRASH ACTIONS 

        def all_notes_in_trash 
            @trash_notes = current_user.trash.gummy_notes
            erb :"/notes/trash/note_trash"
        end

        def added_trash 
            note = GummyNote.find_by(id: params[:id])
            note.trash_id = nil
            note.user_id = current_user.id
            note.save
            redirect "/account/home"
        end

        def empty_trash_bin
            notes = current_user.trash.gummy_notes.all
            notes.destroy_all 
            redirect "/account/home"
        end

        # GUMMY NOTE ACTIONS 

        def create_note
            @note = GummyNote.create(title: params[:title], content: params[:content], color: params[:color])
            @note.user = current_user
            @note.user.gummy_notes << @note
            @color = @note.color
            redirect "/account/home"
        end

        # if users note then show note details
        def show_note
            @note = GummyNote.find_by(id: params[:id])
            @color = @note.color
            erb :"/notes/show_note"
        end

        # if users note then allow user to edit it
        def begin_edit
            @note = GummyNote.find_by(id: params[:id])
            erb :"/notes/edit_note"
        end
        
        # if users note then push edit
        def finish_edit
            @note = GummyNote.find_by(id: params[:id])
            @note.title = params[:title]
            @note.content = params[:content]
            @note.color = params[:color]
            @note.save
            redirect "/account/home"
        end

        def show_all_notes 
            @notes = current_user.gummy_notes
            erb :'/users/account_home'
        end

        def add_to_trash
            @note = GummyNote.find_by(id: params[:id])
            @note.trash = current_user.trash
            @note.trash.gummy_notes << @note
            @note.trash.save
            @note.user = nil
            @note.save
            redirect "/account/home"
        end
    end
end
