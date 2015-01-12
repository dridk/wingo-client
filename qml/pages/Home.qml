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

    function goAbout(){
        appMenu.contractTray();
        app.goToPage(app.pages["About"]);
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
        notesListModel.clear()
        notesListModel.load()
    }




    Component.onCompleted: refresh()


    RestModel{
        id: notesListModel
        source:"/notes"
        onSuccess : {

        }

        onError: {
            console.debug(message)
            app.showMessage("ERROR", message)
        }
    }


    ActionBar {
        id: actionBar
        anchors.top: parent.top
        onMenuClicked: page.menu()
        onRefreshClicked: page.refresh()
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
        model: notesListModel
        busy: notesListModel.isLoading
        enabled: !notesListModel.isLoading

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

        onNewPageRequest: {
            var lastNoteId = notesListModel.last().id;
            notesListModel.setMaxId(lastNoteId)
            notesListModel.load()
        }
    }

    Widgets.ActionButton {
        id: addNoteActionButton        
        enabled: app.logged
        visible: enabled
        onClicked: page.goPost()
    }

    AppMenu{
        id: appMenu
    }
}
