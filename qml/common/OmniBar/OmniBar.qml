import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style
import "../"

Rectangle {
    id: omniBar
    default property alias _contentChildren: filterBarTrayColumn.data
    //Needed for QtCreator design mode
    width: 540
    height: 64
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: omniBarSensorLabel.text
    property bool expanded: omniBarTray.height > 0
    z: expanded ? 99 : 0

    signal expand
    signal contract

    color: Style.Background.VIEW

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

    MouseArea{anchors.fill: parent; enabled: parent.opacity > 0; onClicked: contractTray()} // Block click throughts

    MouseArea{
        id: omniBarSensor
        anchors.rightMargin: 8
        anchors.leftMargin: 16
        anchors.fill: parent
        Label{
            id: omniBarSensorLabel
            anchors.verticalCenter: parent.verticalCenter
            Behavior on color {ColorAnimation {}}
            anchors.rightMargin: 8
            anchors.right: omniBarSensorIcon.left
            anchors.left: parent.left
            elide: Text.ElideRight
        }
        Icon{
            id: omniBarSensorIcon
            name: "expand48"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Behavior on rotation {NumberAnimation{}}
        }
        onClicked: toggleTray()
    }

    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }

    //Page shadowing effect
    Rectangle
    {
        id: overlay
        color: Style.Background.OVERLAY
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: app.height - ( omniBar.y + omniBar.height )
        opacity: 0
        Behavior on opacity {NumberAnimation{}}
    }

    Rectangle{
        id: omniBarTray
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: 0
        clip: true
        color: Style.Background.VIEW
        Behavior on height {NumberAnimation{}}

        ColumnLayout{
            id: filterBarTrayColumn
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0
        //OmniBar contents go here >>>
        }


    }

    states: [
        State {
            name: "EXPANDED"

            PropertyChanges {
                target: omniBarSensorIcon
                rotation: 180
            }

            PropertyChanges {
                target: omniBarTray
                height: Math.min( app.height - ( omniBar.y + omniBar.height ), filterBarTrayColumn.height )
            }

            PropertyChanges {
                target: overlay
                opacity: 1
            }

            PropertyChanges {
                target: omniBarSensorLabel
                color: Style.Typography.FADE
            }
        }
    ]
}
