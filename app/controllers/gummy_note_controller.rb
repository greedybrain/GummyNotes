class GummyNoteController < ApplicationController
    
    # INDEX ACTION
    get "/account/home" do
        show_all_notes
    end

    get "/account/home/search/:title" do
        @gummy_notes = Helper.current_user(session).gummy_notes
        @filter = []
        @gummy_notes.each do |note|
            @filter << note if note.title.include?(params[:title])
        end
        @filter
        erb :"users/account_home"
    end
    
    # CREATE 
    get "/account/notes/new" do
        erb :'/notes/create_note'
    end
    
    post "/account/home" do 
        create_note
    end
    
    
    # READ/SHOW ACTION
    get "/account/notes/:id" do
        show_note
    end

    # UPDATE/EDIT ACTION
    get "/account/notes/:id/edit" do
        begin_edit
    end
    
    patch "/account/notes/:id" do
        finish_edit
    end

    # DESTROY/DELETE ACTION    
    delete "/account/notes/:id" do
        add_to_trash
    end

end
