import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets

import "Home"

Layouts.Page {
    id: page

    function goPost(){
        appMenu.contractTray();
        app.goToPage(app.pages["Post"]);
    }

    function goPocket(){
        appMenu.contractTray();
        app.goToPage(app.pages["Pocket"]);
    }

    function goLogin(){
        appMenu.contractTray();
        app.goToPage(app.pages["Login"]);
    }

    function goAccount() {
        appMenu.contractTray();
        app.goToPage(app.pages["Account"]);
    }

    function refresh(){

        var request = {
            "lat": app.latitude,
            "lon": app.longitude,
            "radius": omniBar.distance,
            "order": omniBar.sortByDate ? "recent" : "popular"
        }
        if (omniBar.search !== "")
                request["query"] = omniBar.search;

        noteList.positionViewAtBeginning()
        notesListModel.clear()
        notesServerRequest.get(request);
    }
    Component.onCompleted: refresh()

    Request {
        id: notesServerRequest
        source: "/notes"
        onSuccess: {
            console.log( data.results.length )
            notesListModel.append(data.results)
        }
        onError: {
            console.debug(message)
        }


    }

// EXAMPLE OF HOW TO USE isLoading and progress property
    Text {
        anchors.centerIn: parent
        z:10
        font.pixelSize: 40
        text:"loading : " + notesServerRequest.downloadProgress*100 +"%"
        visible: notesServerRequest.isLoading
    }
// END OF EXAMPLE.. CAN BE REMOVED

    Item{
        anchors.fill: parent
        ActionBar {
            id: actionBar
            anchors.top: parent.top
            z: omniBar.expanded? 0: 4 //We need this to make sure omniBar tray closes when clicked outside
        }

        OmniBar {
            id: omniBar
            anchors.top: actionBar.bottom
            onContract: {addNoteActionButton.show(); refresh()}
        }

        Layouts.NoteListView {
            id: noteList
            anchors.top: omniBar.bottom
            anchors.bottom: parent.bottom
            model: ListModel{id: notesListModel}

            onVerticalMovementUpChanged: {
                if (verticalMovementUp&&!atYEnd){
                    omniBar.show();
                    addNoteActionButton.show()
                }
            }
            onDistancePassed: {
                if(verticalMovementDown&&!atYBeginning) {
                    addNoteActionButton.hide();
                    omniBar.hide();
                }
            }
            onRefresh: page.refresh()
        }

        Widgets.ActionButton {
            id: addNoteActionButton
            onClicked: page.goPost()
        }
    }

    AppMenu{
        id: appMenu
    }








}
