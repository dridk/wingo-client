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
            "lat": app.coordinate.latitude,
            "lon": app.coordinate.longitude,
            "radius": omniBar.distance,
            "order": omniBar.sortByDate ? "recent" : "popular"
        }
        if (omniBar.search !== "")
            request["query"] = omniBar.search;

        notesListModel.setParams(request);
        notesListModel.reload()
    }


    Component.onCompleted: refresh()


    RestModel{
        id: notesListModel
        source:"/notes"
        onSuccess : {
            makeToast("Sucessfully refreshed")
            noteList.positionViewAtBeginning()

            noteFilterModel.fi
            noteFilterModel.setFilterKey("$anonymous")
            noteFilterModel.setFilterRegExp(/.*/)




        }

        onError: {
            console.debug(message)
            app.showMessage("ERROR", message)

            console.debug(notesListModel.count())
        }
    }

    FilterRestModel {
        id:noteFilterModel
        filterCaseSensitivity: Qt.CaseInsensitive
        restModel : notesListModel


    }


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
        model: noteFilterModel
        busy: notesListModel.isLoading

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


            onClicked: {
                var noteId = notesListModel.get(index).id
                app.goToPage(app.pages["View"]);
                app.currentPage.noteId = noteId
            }
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
