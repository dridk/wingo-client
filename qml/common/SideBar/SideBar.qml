import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style

Item {
    id: sideBar
    default property alias _contentChildren: sideBarTrayColumn.data
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------
    anchors.fill: parent
    clip: true

    property bool expanded: sideBarTray.anchors.leftMargin === 0
    z: expanded ? 99 : 0

    signal expand
    signal contract

    function toggleTray(){
        if (state == "EXPANDED")  contractTray()
        else expandTray()
    }

    function expandTray(){
        state = "EXPANDED"
        expand()
    }

    function contractTray(){
        state = ""
        contract()
    }

    // Block click throughts

    //Page shadowing effect
    Rectangle
    {
        id: overlay
        color: Style.Background.OVERLAY
        anchors.fill: parent
        opacity: 0
        Behavior on opacity {NumberAnimation{}}
        MouseArea{anchors.fill: parent; enabled: parent.opacity > 0; onClicked: sideBar.contractTray()}
    }

    Rectangle{
        id: sideBarTray
        width: parent.width * 0.8
        height: parent.height
        color: Style.Background.VIEW
        x: -width
        Behavior on x {NumberAnimation{}}

        ColumnLayout{
            id: sideBarTrayColumn
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0
        }

    }
    
    
    
    states: [
        State {
            name: "EXPANDED"

            PropertyChanges {
                target: sideBarTray
                x: 0
            }

            PropertyChanges {
                target: overlay
                opacity: 1
            }
        }
    ]

}
