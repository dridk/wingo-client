import QtQuick 2.3
import Wingo 1.0
import QtQuick.Controls 1.2
import QtPositioning 5.2

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../scripts/DateFormat.js" as DateFormat
import "../scripts/StringFormat.js" as StringFormat
import "../scripts/DistanceFormat.js" as DistanceFormat
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar
import "../common/Components" as Componenets

import "View"

Layouts.Page {
    id: page

    property string noteId

    onHidden: {
        //Empty all image data
        noteView.avatar = ""
        noteView.image = ""
    }

    onShown: {
        // Load note from the note identifier
        console.debug("Load NoteView data " + noteId)
        noteViewRequester.source = "/notes/" + noteId
        noteViewRequester.get()

        postCommentRequester.source="/notes/" + noteId +"/comments"
        commentModel.source="/notes/" + noteId +"/comments"
        commentModel.load()
    }

    ActionBar.Widget {
        id: actionBar
        ActionBar.Title {
            id: pageTitle
            style: actionBar.style
            icon: Icons.CARRET_LEFT
            text: qsTr("Looking up note<br>location...")
            onClicked: page.back()
        }

        ActionBar.Right {
            ActionBar.Button {
                //Share
                icon: Icons.SHARE
                onClicked: {
                    //http://en.wikipedia.org/wiki/Geo_URI
                    var url = "geo:"+mapView.center.latitude+","+mapView.center.longitude+
                            "?q="+mapView.center.latitude+","+mapView.center.longitude+"("+noteView.message+")"
                    console.debug(url);
                    Qt.openUrlExternally(url);

                }
            }
            ActionBar.Action {
                style: "ACCENT"
                icon: Icons.POCKET_ADD
                visible: app.logged

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

    Componenets.Flickable {
        id: noteViewFlickable
        anchors.top: actionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: noteViewColumn.height
        interactive: height < contentHeight

        Column {
            id: noteViewColumn
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0



            Note{
                id: noteView
                z: 3
            }

//            TextField {
//                width : parent.width
//                height: 50
//                text:"MESSAGE...."
//                onAccepted: {

//                    var request = {"message": text }
//                    postCommentRequester.post(request)

//                }
//            }

            Widgets.MapView{
                id: mapView
                noteID: noteId
                enabled: true
                z: 2
            }


            Widgets.EntryArea {
                id: commentView
                placeholder: qsTr("Leave your comment...")
                z: 1

                anchors.left: parent.left
                anchors.right: parent.right

                maxTextLength: 128

                action: Icons.SEND

                enabled: app.logged
                visible: enabled

//                onFocusChanged: {
//                    if(focus) {
//                        Qt.inputMethod.setInputItemRectangle(Qt.rect(x,y,width,height))
//                    }
//                }

                onActionPressed: {

                    var request = {"message": text }
                    postCommentRequester.post(request)
                    clear()

                }
            }

            Layouts.CommentListView {
                id: commentListView
                z: 1
                busy: postCommentRequester.isLoading
                opacity: busy? 0.8: 1

                model: RestModel {
                    id:commentModel

                    onSuccess: console.debug("COMMENTS LOADED...")
                    onError: console.debug(message)


                }

            }

        }
    }

    Widgets.ScrollIndicator {
        attachTo: noteViewFlickable
        showScrollBarWhen: noteViewFlickable.movingVertically
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
                                                     "days ago"),
                                                    qsTr("mon ago"), qsTr("yr ago")]) +
                    ", " +
                    DistanceFormat.toHere(app.coordinate,
                                              QtPositioning.coordinate(data["results"]["lat"], data["results"]["lon"]),
                                              [qsTr("here"), qsTr("m"), qsTr("km"), qsTr("far...")])
            noteView.takes = data["results"]["takes"]
            noteView.expiration = data["results"]["expiration"]

            if (data["results"]["picture"]) noteView.image = data["results"]["picture"]

            noteView.message = StringFormat.setWordColor(data["results"]["message"],
                                                         Style.Typography.LINK, /\#\w+/g)

            noteView.commentCount = data["results"]["comment_count"]

            mapView.center = QtPositioning.coordinate(
                data["results"]["lat"],
                data["results"]["lon"]
            )

            locationRequest.get({lat:data["results"]["lat"],lon:data["results"]["lon"]})
        }
        onError: app.showMessage("ERROR", message)
    }

    Request {
        id:locationRequest
        source:"/location/here"
        onSuccess: {
            pageTitle.text = data["results"]
        }
    }

    Request {
        id: takeNoteRequester
        source: "/users/pockets"
        onSuccess: {
            app.makeToast(qsTr("Note placed into pocket"))
            app.pocket_count++
            noteView.takes++
         }
        onError: app.showMessage("ERROR", message)
    }

    Request {
        id: postCommentRequester
        onSuccess: {
            commentModel.clear()
            commentModel.load()
            noteView.commentCount++
        }

    }
}
