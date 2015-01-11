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
    Component.onCompleted: refresh()

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
            for(var i = 0; i < noteList.count; i++){
            }

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

            selectable: page.selectionMode

            function remove(){
                if (!selected) return;
              var noteId = pocketNoteModel.get(index).parent;
                console.debug("DELETE " + noteId)
                pocketNoteRequest.source = "/users/pockets/"+noteId;
                pocketNoteRequest.deleteResource();
                pocketNoteModel.remove(index)
            }

            onClicked: {
                if (page.selectionMode){
                    selectionToggle()
                    //do something
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

}
