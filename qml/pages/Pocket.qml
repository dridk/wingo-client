import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets

import "Pocket"

Layouts.Page {
    id: page
    property bool selectionMode : false

    function refresh(){
        noteList.positionViewAtBeginning()
       pocketNoteModel.load();
    }

    Component.onCompleted: refresh()

    RestModel {
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
        onCheckmakClicked:{
             page.selectionMode = !page.selectionMode
            console.debug(page.selectionMode)
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
        header:  Rectangle {
            width: parent.width
            height:page.selectionMode ? 200 : 0
            visible: page.selectionMode
            onHeightChanged: {
                noteList.positionViewAtBeginning()
            }
            Text {
                text: "Drag to remove items"
                anchors.centerIn: parent
            }



        }

        delegate: Layouts.NoteListItem {
            lat: $lat
            lon: $lon
            timestamp: $timestamp
            message: $message
            //POCKET NOTE IS A COPY A NOTES... THERE ARE NO AUTHOR.
            // YOU CAN GO TO THE ORIGINAL NOTES TO SEE IT
//            anonymous: $anonymous
//            nickname: $anonymous ? "" :$author.nickname

            //QR CODE : CHECK http://goqr.me/api/doc/create-qr-code/#general_tos

            avatar: "https://api.qrserver.com/v1/create-qr-code/?size=150x150&color=00B8CC&data="+$signature
//            takesCount: $takes
            picture: $picture == undefined ? "" : $picture
            draggable: page.selectionMode

            onClicked: {
//                if (!noteList.selectionsMode){
                    // Remind : packet has parent, not id
                var noteId = pocketNoteModel.get(index).parent
                app.goToPage(app.pages["View"]);
                app.currentPage.noteId = noteId
//                }
//                else {
//                    // Remind : packet has parent, not id
//                    console.debug("DELETE")
//                    var noteId = pocketNoteModel.get(index).parent;
//                    pocketNoteRequest.source = "/users/pockets/"+noteId;
//                    pocketNoteRequest.deleteResource();
//                    pocketNoteModel.remove(index)
//                }
            }

            onDraggedIn: {
                console.debug("DELETE Cancel")
            }

            onDraggedOut: {
                    // Remind : packet has parent, not id
                console.debug("DELETE")
                app.makeToast("Note removed from Pocket", Style.MESSAGE_PURPOSE_ALERT)
                  var noteId = pocketNoteModel.get(index).parent;
                    pocketNoteRequest.source = "/users/pockets/"+noteId;
                    pocketNoteRequest.deleteResource();
                    pocketNoteModel.remove(index)
            }

            Text {
                text :$signature
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

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

    Request {
        id:pocketNoteRequest

        //success message is un necessary...
        onSuccess: {
            app.showMessage("delete from pockets", "Delete success")
            app.pocket_count--


        }
        onError: app.showMessage("delete from pockets","Cannot delete notes")

    }

}
