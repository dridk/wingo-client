import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../scripts/DateFormat.js" as DateFormat
import "../scripts/StringFormat.js" as StringFormat
import "../scripts/DistanceFormat.js" as DistanceFormat
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar

import "View"

Layouts.Page {
    id: page

    property string noteId

    onNoteIdChanged: {
        // Load note from the note identifier
        console.debug("Load NoteView data " + noteId)
        noteViewRequester.source = "/notes/" + noteId
        noteViewRequester.get()
    }

    ActionBar.Widget {
        id: actionBar
        ActionBar.Title {
            style: actionBar.style
            icon: Icons.CARRET_LEFT
            text: noteId
            onClicked: page.back()
        }

        ActionBar.Right {
            ActionBar.Button {
                //Share
                icon: Icons.SHARE
            }
            ActionBar.Action {
                style: "ACCENT"
                icon: Icons.POCKET_ADD
                enabled: app.logged

                onClicked: {
                    //Add This note to the current pockets users
                    console.debug("Add note to pockets")
                    takeNoteRequester.post({
                                               note_id: noteId
                                           })
                }
            }
        }
    }

    Note{
        id: noteView
        anchors.top: actionBar.bottom
    }

//    Text {
//        id: item
//        width: parent.width
//        anchors.centerIn: parent
//        wrapMode: Text.WordWrap
//    }

    //======= JUST A TEST =====================
//    Image {
//        source: "http://localhost:5000/notes/" + noteId + "/map"

//        onStatusChanged: {
//            console.debug(source)
//        }
//    }

    //======= JUST A TEST =====================
    Request {
        id: noteViewRequester
        onSuccess: {

            if (data["results"]["anonymous"] === false) {

            noteView.avatar = data["results"]["author"]["avatar"]
            noteView.nickname = data["results"]["author"]["nickname"]
            }

            noteView.details = DateFormat.toNow(data["results"]["timestamp"],
                                                [qsTr("just now"), qsTr(
                                                     "min ago"), qsTr("h ago"), qsTr(
                                                     "mon ago"), qsTr(
                                                     "days ago"), qsTr("yr ago")]) +
                    ", " +
                    DistanceFormat.toHere(
                                              DistanceFormat.pointObject(app.latitude,
                                                                         app.longitude),
                                              DistanceFormat.pointObject(data["results"]["lat"], data["results"]["lon"]),
                                              [qsTr("here"), qsTr("m"), qsTr("km"), qsTr("far...")])
            noteView.takes = data["results"]["takes"]
            noteView.expiration = data["results"]["expiration"]

            noteView.message = StringFormat.setWordColor(data["results"]["message"],
                                                         Style.Typography.LINK, /\#\w+/g)
        }
        onError: app.showMessage(message)
    }

    Request {
        id: takeNoteRequester
        source: "/users/pockets"
        onSuccess: app.showMessage("Note has been added in pocket")
        onError: app.showMessage(message)
    }
}
