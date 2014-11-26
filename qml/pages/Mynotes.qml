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
        notesListModel.clear()
       pocketNoteRequester.get();
    }
    Component.onCompleted: refresh()

    Request {
        id: pocketNoteRequester
        source: "/users/pockets"
        onSuccess: {
            console.log( data.results.length )
            notesListModel.append(data.results)
        }
        onError: {
            console.debug(message)
        }
    }

    ActionBar {
        id: actionBar
        anchors.top: parent.top
        z: omniBar.expanded? 0: 4 //We need this to make sure omniBar tray closes when clicked outside
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

        model: ListModel{id: notesListModel}

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
