class ApplicationController < Sinatra::Base

    configure do 
        set :views, "app/views" # telling sinatra to look inside my app directory for a views folder which houses all of my view templates
        set :public_folder, "public" # telling sinatra to look for a public folder which houses all of my styling, images, etc
        enable :sessions # allows me to keep track of user state
        set :session_secret, "s7y7n7t7a7x7t7i7c" # the not recommended way of setting a session secret, I would use a randomly generated HEX value instead
    end

    # HOME PAGE SIGNUP/LOGIN/ETC

    get "/" do # path to my root page
        if Helper.logged_in?(session) # checks if a user is logged in
            redirect "/account/home" # if so, redirects to the users homepage
        else
            erb :'/root/index' # otherwise it renders the root page
        end
    end

    # ========================================
    # HELPERS HELPERS HELPERS HELPERS HELPERS
    # ========================================

    helpers do # allows me to use helper functions throughout my application, enables me to keep things abstracted

        # USER 

        def logging_in
            @user = User.find_by(username: params[:username].downcase)
        
            if @user && @user.authenticate(params[:password])
                session[:username] = @user.username
                redirect '/account/home'
            else
                erb :'/users/login'
            end
        end

        def show_home
            if Helper.logged_in?(session)
                redirect '/account/home'
            else 
                erb :'/users/login'
            end
        end

        def register_user
            @user = User.new(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
            
            assigned_trash_can(@user)

            if @user.save
                session[:username] = @user.username
                redirect '/account/home'
            else
                erb :'/users/signup'
            end     
        end

        def assigned_trash_can(user) 
            trash_can = Trash.create 
            user.trash = trash_can
            trash_can.user = user
            trash_can
        end

        def go_home
            if logged_in?
                erb :'/users/account_home.html'
            else
                erb :'/users/login'
            end
        end

        def settings_page_or
            if Helper.logged_in?(session)
                erb :'/help/settings'
            end
        end

        def logging_out
            if Helper.logged_in?(session)
                session.clear 
                redirect "/login"
            end
        end

        def delete_account
            user = User.find_by_id(current_user.id)
            user.gummy_notes.destroy_all
            session.clear
            user.delete
            redirect "/login"
        end

        # TRASH ACTIONS 

        def all_notes_in_trash 
            @trash_notes = Helper.current_user(session).trash.gummy_notes
            erb :'/notes/trash/note_trash'
        end

        def added_trash 
            note = GummyNote.find_by(id: params[:id])
            note.trash_id = nil
            note.user_id = Helper.current_user(session).id
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
            @note.user = Helper.current_user(session)
            @note.user.gummy_notes << @note
            @color = @note.color
            redirect "/account/home"
        end

        # if users note then show note details
        def show_note
            @note = GummyNote.find_by(id: params[:id])
            @color = @note.color
            erb :'/notes/show_note'
        end

        # if users note then allow user to edit it
        def begin_edit
            @note = GummyNote.find_by(id: params[:id])
            erb :'/notes/edit_note'
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
            @notes = Helper.current_user(session).gummy_notes
            erb :'/users/account_home'
        end

        def add_to_trash
            @note = GummyNote.find_by(id: params[:id])
            @note.trash = Helper.current_user(session).trash
            @note.trash.gummy_notes << @note
            @note.trash.save
            @note.user = nil
            @note.save
            redirect "/account/home"
        end
    end
end
