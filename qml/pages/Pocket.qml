import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets

import "Pocket"

Layouts.Page {
    id: page

    function back(){
        app.goBack();
    }

    function refresh(){
        noteList.positionViewAtBeginning()
       pocketNoteModel.reload();
    }
    Component.onCompleted: refresh()

    RestListModel {
        id: pocketNoteModel
        source: "/users/pockets"
        onSuccess: {
            console.log("pokets load success" )
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

        model: pocketNoteModel

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
