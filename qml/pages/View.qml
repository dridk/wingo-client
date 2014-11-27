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

    Flickable {
        id: noteViewFlickable
        flickableDirection: Flickable.VerticalFlick
        anchors.top: actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: noteViewColumn.height
        boundsBehavior: Flickable.StopAtBounds
        interactive: true
        Column {
            id: noteViewColumn
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0

            Note{
                id: noteView
                z: 3
            }

            Widgets.MapView{
                id: mapView
                noteID: noteId
                z: 2
            }

            Layouts.CommentListView{
                id: commentListView
                z: 1
                model: ListModel{
                    Component.onCompleted: {
                        this.append(
                                 {"author": {"avatar": "http://api.randomuser.me/portraits/thumb/men/80.jpg","nickname": "greendog751"},
                                        "timestamp": "2014-11-04 09:09:21.620000",
                                        "message": "La Daurade : Fames ipsum porta fusce turpis luctus risus morbi lobortis ridiculus interdum lorem velit netus. Proin fames. Risus done #style #colorful"}
                                    )
                        this.append(
                                 {"author": {"avatar": "http://api.randomuser.me/portraits/thumb/men/80.jpg","nickname": "greendog751"},
                                        "timestamp": "2014-11-04 09:09:21.620000",
                                        "message": "La Daurade : Fames ipsum porta fusce"}
                                    )
                        this.append(
                                 {"author": {"avatar": "http://api.randomuser.me/portraits/thumb/men/80.jpg","nickname": "greendog751"},
                                        "timestamp": "2014-11-04 09:09:21.620000",
                                        "message": "La Daurade : Fames ipsum porta fusce turpis luctus risus velit netus. Proin fames. Risus done #style #colorful"}
                                    )
                    }
                }
            }
        }
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
            noteView.avatar = data["results"]["anonymous"]? "": data["results"]["author"]["avatar"]
            noteView.nickname = data["results"]["anonymous"]? "Anonymous": data["results"]["author"]["nickname"]
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
            mapView.latitude = data["results"]["lat"]
            mapView.longitude = data["results"]["lon"]
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
