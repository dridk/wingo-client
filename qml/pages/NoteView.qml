import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar

import "Pocket"

Layouts.Page {
    id: page

    property string noteId

    function back(){
        app.goBack();
    }


    onNoteIdChanged: {
        // Load note from the note identifier
        console.debug("Load NoteView data "+ noteId)
        noteViewRequester.source="/notes/"+noteId
        noteViewRequester.get()
    }

    Item{
        anchors.fill: parent

        ActionBar.Widget {
            id: actionBar
            style: "ALTERNATIVE"
            ActionBar.Title {
                style: actionBar.style
                icon: Icons.CARRET_LEFT
                text: noteId
                onClicked: page.back()
            }
            ActionBar.Right{
                ActionBar.Button{
                    icon: Icons.POCKET
                    enabled: app.logged

                    onClicked: {
                        //Add This note to the current pockets users
                        console.debug("Add note to pockets")
                        takeNoteRequester.post({"note_id": noteId})
                    }
                }

            }
        }


   Text {
        id:item
        width: parent.width
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
   }


    }

    Request {
        id:noteViewRequester
        onSuccess:  item.text = data["results"]["message"]
         onError: app.showMessage(message)
    }

    Request {
        id:takeNoteRequester
        source: "/users/pockets"
        onSuccess: app.showMessage("Note has been added in pocket")
        onError : app.showMessage(message)

    }

}
