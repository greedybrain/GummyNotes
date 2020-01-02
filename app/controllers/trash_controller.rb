class TrashController < ApplicationController

    get "/account/trash/notes" do 
        all_notes_in_trash
    end

    post "/account/notes/:id" do
        added_trash
    end

    delete "/account/notes/trash" do 
        empty_trash_bin
    end

end