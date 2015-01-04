import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets

import "Mynotes"

Layouts.Page {
    id: page

    function back(){
        app.goBack();
    }

    function refresh(){

        noteList.positionViewAtBeginning()
        myNoteModel.reload()
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

            draggable: true

            onClicked: {
                var noteId = myNoteModel.get(index).id
                app.goToPage(app.pages["View"]);
                app.currentPage.noteId = noteId
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
