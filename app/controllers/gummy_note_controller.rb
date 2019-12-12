class GummyNoteController < ApplicationController
    
    # INDEX ACTION
    get "/account/home" do
        @notes = current_user.gummy_notes
        erb :'/users/account_home'
    end
    
    # CREATE 
    get "/account/notes/new" do
        eligible_to_create?
    end
    
    post "/account/home" do 
        @note = GummyNote.create(title: params[:title], content: params[:content], color: params[:color])
        associate_note_and_user(@note)
        @color = @note.color
        create(@note)
    end
    
    
    # READ/SHOW ACTION
    get "/account/notes/:id" do |id|
        @note = GummyNote.find_by_id(id)
        @color = @note.color
        show(@note)
    end

    # UPDATE/EDIT ACTION
    get "/account/notes/:id/edit" do |id|
        @note = GummyNote.find_by_id(id)
        edit(@note)
    end
    
    patch "/account/notes/:id" do |id|
        @note = GummyNote.find_by_id(id)
        @color = @note.color
        patch(@note)
    end

    # DESTROY/DELETE ACTION    
    delete "/account/notes/:id" do |id|
        @note = GummyNote.find_by_id(id)
        @note.trash = current_user.trash
        # @note.trash = assigned_trash_can(current_user)
        @note.trash.gummy_notes << @note
        @note.trash.save
        @note.user = nil
        @note.save
        redirect "/account/home"
    end

# =============== HELPER METHODS ====================

    # Confirming creation authority
    def eligible_to_create?
        if logged_in? 
            erb :'/notes/create_note'
        else
            redirect "/"
        end
    end

    def create(note) 
        note = GummyNote.find_by(id: params[:id])
        redirect "/account/home"
    end

    # if confirmed, then create a note
    def associate_note_and_user(note)
        if eligible_to_create?
            note.user = current_user
            current_user.gummy_notes << note
        end
    end

    # DOES NOTE BELONG TO USER?
    def note_belongs_to_user?(note)
        current_user.gummy_notes.include?(note)
    end

    # if users note then show note details
    def show(note)
        erb :"/notes/show_note"
    end

    # if users note then allow user to edit it
    def edit(note)
        if note_belongs_to_user?(note)
             erb :"/notes/edit_note"
        else
            redirect('/account/home')
        end
    end
    
    # if users note then push edit
    def patch(note)
        if note_belongs_to_user?(note)
            note = GummyNote.find_by(id: params[:id])
            note.title = params[:title]
            note.content = params[:content]
            note.color = params[:color]
            note.save
            redirect "/account/home"
        end
    end

    # def garbage_collection
    #     # assigned_trash_can(current_user).gummy_notes
    # end

end
