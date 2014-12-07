import QtQuick 2.0
import Wingo 1.0

import "../scripts/Utilities.js" as Utilities
import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets

import "Home"

Layouts.Page {
    id: page

//    function beforeShown() {noteList.re}
    function back() {/*do nothing*/}
    function menu() {appMenu.toggleTray()}

    function goPost(){
        appMenu.contractTray();
        app.goToPage(app.pages["Post"]);
    }

    function goPocket(){
        appMenu.contractTray();
        app.goToPage(app.pages["Pocket"]);
    }

    function goMynotes(){
        appMenu.contractTray();
        app.goToPage(app.pages["Mynotes"]);
    }

    function goLogin(){
        appMenu.contractTray();
        app.goToPage(app.pages["Login"]);
    }

    function goAccount() {
        appMenu.contractTray();
        app.goToPage(app.pages["Account"]);
    }

    function goSettings() {
        appMenu.contractTray();
        app.goToPage(app.pages["Settings"]);
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

        notesServerRequest.get(request);

        //Request location for titleBar
        locationRequester.get({"lat": app.latitude, "lon":app.longitude})


    }
    Component.onCompleted: refresh()

    Request {
        id: notesServerRequest
        source: "/notes"
        onSuccess: {
            console.log( data.results.length )
//            var diff = Utilities.diffArray()
            Utilities.applyFunction(data.results, function(item, index){

            });

            notesListModel.clear()
            notesListModel.append(data.results)
            noteList.positionViewAtBeginning()
        }
        onError: {
            console.debug(message)
        }


    }

    Request {
        id:locationRequester
        source:"/location/here"
        onSuccess: {
            actionBar.title  = data["results"]
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

    ActionBar {
        id: actionBar
        anchors.top: parent.top
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

        onPressed: {
            var noteId = model.get(index).id
            app.goToPage(app.pages["View"]);
            app.currentPage.noteId = noteId


        }

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

    AppMenu{
        id: appMenu
    }


}
