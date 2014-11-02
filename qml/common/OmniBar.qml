import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style

Rectangle {
    id: omniBar
    default property alias _contentChildren: omniBarTray.data
    //Needed for QtCreator design mode
    width: 540
    height: 64
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: omniBarSensorLabel.text
    property bool expanded: omniBarTray.height > 0
    z: expanded ? 99 : 0

    signal expanded
    signal contracted

    color: Style.Background.VIEW

    function toggle(){
        if (state == "EXPANDED")  contract()
        else expand()
    }

    function expand(){
        state = "EXPANDED"
        expanded()
    }

    function contract(){
        state = ""
        contracted()
    }

    MouseArea{
        id: omniBarSensor
        anchors.rightMargin: 8
        anchors.leftMargin: 16
        anchors.fill: parent
        Label{
            id: omniBarSensorLabel
            text: omniBar.omniBarSensorLabelText()
            anchors.verticalCenter: parent.verticalCenter
            Behavior on color {ColorAnimation {}}
        }
        Icon{
            id: omniBarSensorIcon
            name: "expand48"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Behavior on rotation {NumberAnimation{}}
        }
        onClicked: toggle()
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
        height: 0
        opacity: 0
        Behavior on opacity {NumberAnimation{duration: page.backgroundAnimationDuration}}
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

        //OmniBar contents go here >>>



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
                height: app.height - ( omniBar.y + omniBar.height )
            }

            PropertyChanges {
                target: overlay
                height: app.height - ( omniBar.y + omniBar.height )
                opacity: 1
            }

            PropertyChanges {
                target: omniBarSensorLabel
                color: Style.Typography.FADE
            }
        }
    ]
}
