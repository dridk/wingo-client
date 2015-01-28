import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets

import "Mynotes"

Layouts.Page {
    id: page
    property bool selectionMode : false

    function back(){
        app.goBack();
    }

    function refresh(){

        noteList.positionViewAtBeginning()
        myNoteModel.load()
    }
//    Component.onCompleted: refresh()
    onShown: {
        if (myNoteModel.count < 1) refresh();
    }// This repaces the above statement

    RestModel {
        id: myNoteModel
        source: "/users/mynotes"
        onSuccess: {
            console.log("my notes loaded")
        }
        onError: {
            console.debug(message)
        }
    }

    ActionBar {
        id: actionBar
        anchors.top: parent.top
        showTrash: page.selectionMode

        onCheckmakClicked:{
             page.selectionMode = !page.selectionMode
            console.debug(page.selectionMode)
        }
        onTrashClicked: {
            for (var index in myNoteModel.selection()) {

                var noteId = myNoteModel.get(myNoteModel.selection()[index])["id"]
                if (noteId) {
                    myNoteRequest.source = "/notes/"+noteId;
                    myNoteRequest.deleteResource();
                }

            }

            //remove UI items
            myNoteModel.removeSelection();

            //clear UI selection
            myNoteModel.clearSelection();

            page.selectionMode = false
            app.makeToast("Note(s) deleted", Style.MESSAGE_PURPOSE_ALERT)
        }

        onBackClicked: app.goBack()
    }

    OmniBar {
        id: omniBar
        anchors.top: actionBar.bottom
    }

    Layouts.NoteListView {
        id: noteList
        anchors.top: omniBar.bottom
        anchors.bottom: parent.bottom
        refreshOnPull: false
        busy: myNoteModel.isLoading
        enabled: !myNoteModel.isLoading

        model: myNoteModel



        delegate: Layouts.NoteListItem {
            lat: $lat
            lon: $lon
            timestamp: $timestamp
            message: $message
            anonymous: $anonymous
            nickname: $anonymous ? "" :$author.nickname
            avatar: $anonymous ? "" :$author.avatar
            takesCount: $takes
            picture: $picture == undefined ? "" : $picture
            commentCount: $comment_count

            selectable: page.selectionMode

            function remove(){
                if (!selected) return;
              var noteId = pocketNoteModel.get(index).parent;
                console.debug("DELETE " + noteId)

                pocketNoteModel.remove(index)
            }

            onClicked: {
                if (page.selectionMode){
                    selectionToggle()
                    myNoteModel.setSelection(index, selected)



                }else{
                    var noteId = myNoteModel.get(index).id
                    app.goToPage(app.pages["View"]);
                    app.currentPage.noteId = noteId
                }
            }
        }


        onVerticalMovementUpChanged: {
            if (verticalMovementUp&&!atYEnd){
                omniBar.show();
            }
        }
        onDistancePassed: {
            if(verticalMovementDown&&!atYBeginning) {
                omniBar.hide();
            }
        }
        onRefresh: page.refresh()
    }

    Request {
        id:myNoteRequest
        onSuccess: {
//            app.showMessage("delete from mynotes", "Delete success")
            app.mynote_count--


        }
        onError: app.showMessage("delete from mynotes","Cannot delete notes")

    }

}
