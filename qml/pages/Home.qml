import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../scripts/AppStyle.js" as Style
import "../common"

Page {
    id: page
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------

    icon: "wingo48"
    title: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"
    defaultAction: Style.ACTION_BAR_MENU_ACTION

    actionsListModel: ListModel{
        ListElement {
            icon: "refresh48"
            name: "refresh"
        }
        ListElement {
            icon: "pocket48"
            name: "pocket"
        }
    }

    onMenuButtonClicked: console.log("Menu from Home")
    onActionButtonClicked: {
        console.log("Action button " + name + " clicked at index " + index)
        switch (index){
        case 0:
            refresh()
            break;
        }
    }

    function refresh(){
        notesServerRequest.get({"at": app.latitude+","+app.longitude, "radius": filterbar.distance, "query": filterbar.search})
    }

    Request {
        id: notesServerRequest
        source: "/notes"
        onSuccess: {
            notesListModel.clear()
            for (var index in data.results){
                notesListModel.append(data.results[index])
            }
        }
        onError: {
            console.debug(message)
        }
    }

    FilterBar {
        id: filterbar
        anchors.top: parent.top
        onSearchChanged: {
            refresh()
            contract()
        }
    }

    Item{
        anchors.top: filterbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true

        ListView {
            anchors.fill: parent

            model: ListModel{
                id: notesListModel
            }
            //                ListModel{
            //                ListElement{
            //                    noteAuthor: "Someone"
            //                    noteAvatar: "url://"
            //                    noteAnonymous: false
            //                    noteMessage: "There is a cute dog here :) Come check it out - it's soooo cuuuute!! I really like dogs, especially cute ones!"
            //                    noteLocation: []
            //                    noteExpiration: ""
            //                    noteTimestamp: ""
            //                    noteTakes: 5
            //                    noteLimit: 10
            //                    noteTags: []
            //                }
            //                ListElement{
            //                    noteAnonymous: true
            //                    noteMessage: "Hey guys! Mad party going on here >>"
            //                    noteLocation: []
            //                    noteExpiration: ""
            //                    noteTimestamp: ""
            //                    noteTakes: 5
            //                    noteLimit: 10
            //                    noteTags: []
            //                }
            //                ListElement{
            //                    noteAuthor: "Someone2"
            //                    noteAvatar: "url://"
            //                    noteAnonymous: false
            //                    noteMessage: "This is a free online calculator which counts the number of characters or letters in a text, useful for your tweets on Twitter, as well as a multitude of other applications."
            //                    noteLocation: []
            //                    noteExpiration: ""
            //                    noteTimestamp: ""
            //                    noteTakes: 5
            //                    noteLimit: 10
            //                    noteTags: []
            //                }
            //            }

            delegate: NoteListItem{}
        }

    }

    Rectangle{
        anchors.right: parent.right
        anchors.left: parent.left
        height: 64
        color: Qt.rgba(255, 255, 255, 0.95)
        anchors.bottom: parent.bottom
        Label{
            text: "Post new note..."
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            color: Style.Typography.FADE
        }
        MouseArea{
            anchors.fill: parent
            onClicked: app.goToPage(app.pages["AddNote"])
        }
    }

}
