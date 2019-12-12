class TrashController < ApplicationController

    get "/account/trash/notes" do 
        if logged_in?
            @trash_notes = current_user.trash.gummy_notes
            erb :"/notes/trash/note_trash"
        end
    end

end