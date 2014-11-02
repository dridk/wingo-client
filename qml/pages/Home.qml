import QtQuick 2.0
import QtQuick.Layouts 1.1

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
             app.goToPage(app.pages["AddNote"])
             break;
        }
    }

    FilterBar {
        id: filterbar
        anchors.top: parent.top
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
                ListElement{
                    noteAuthor: "Someone"
                    noteAvatar: "url://"
                    noteAnonymous: false
                    noteMessage: ""
                    noteLocation: []
                    noteExpiration: ""
                    noteTimestamp: ""
                    noteTakes: 5
                    noteLimit: 10
                    noteTags: []
                }
                ListElement{
                    noteAnonymous: true
                    noteMessage: ""
                    noteLocation: []
                    noteExpiration: ""
                    noteTimestamp: ""
                    noteTakes: 5
                    noteLimit: 10
                    noteTags: []
                }
                ListElement{
                    noteAuthor: "Someone2"
                    noteAvatar: "url://"
                    noteAnonymous: false
                    noteMessage: ""
                    noteLocation: []
                    noteExpiration: ""
                    noteTimestamp: ""
                    noteTakes: 5
                    noteLimit: 10
                    noteTags: []
                }
            }

            delegate: Rectangle{
                anchors.left: parent.left
                anchors.right: parent.right
                height: childrenRect.height
                color: Style.Background.VIEW

                RowLayout{
                    ColumnLayout{
                        Label{text: noteAuthor}
                        Label{text: noteMessage}
                    }
                    ColumnLayout{

                    }
                }

                Rectangle{
                    height: 2
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    color: Style.Border.DEFAULT
                }
            }
        }

    }


}
