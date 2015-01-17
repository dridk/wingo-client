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

    function back() {
        if (appMenu.expanded) appMenu.contractTray();
        if (omniBar.expanded) omniBar.contractTray();
        return true;
    }
    function menu() {
        if (omniBar.expanded) omniBar.contractTray();
        if (!appMenu.expanded) appMenu.expandTray();
        else appMenu.contractTray();
        return true;
    }

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
        notesListModel.countNew = 0
        notesListModel.load()
    }

    Component.onCompleted: refresh()

    RestModel{
        id: notesListModel
        source:"/notes"

        property int countOld: 0
        property int countNew: 0
        property bool more: countOld != countNew

        onSuccess : {
            countOld = countNew
            countNew = count
        }

        onError: {
            console.debug(message)
            app.showMessage("ERROR", message)
        }
    }


    ActionBar {
        id: actionBar
        anchors.top: parent.top
        onMenuClicked: appMenu.toggleTray()
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
            commentCount: $comment_count



            onClicked: {
                var noteId = notesListModel.get(index).id
                app.goToPage(app.pages["View"]);
                app.currentPage.noteId = noteId
            }
        }

        footer: Layouts.NoteListFooter{
            text: qsTr("more...")
            visible: notesListModel.count < notesListModel.totalCount
            onClicked: {
                    var lastNoteId = notesListModel.last().id;
                    notesListModel.setMaxId(lastNoteId)
                    notesListModel.load()
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

//        onNewPageRequest: {
//            var lastNoteId = notesListModel.last().id;
//            notesListModel.setMaxId(lastNoteId)
//            notesListModel.load()
//        }
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
