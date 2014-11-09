import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style
import "../../scripts/Utilities.js" as Utilities
import "../"

Rectangle {
    id: omniBar
    default property alias _contentChildren: filterBarTrayColumn.data
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_OMNI_BAR_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: omniBarSensorLabel.text
    property bool expanded: omniBarTray.height > 0
    property bool fillHeight: false
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
        omniBarTrayFlickable.contentY = 0
        contract()
    }

    MouseArea{anchors.fill: parent; enabled: parent.opacity > 0; onClicked: contractTray()} // Block click throughts

    MouseArea{
        id: omniBarSensor
        anchors.rightMargin: _RES.s_MARGIN
        anchors.leftMargin: _RES.s_DOUBLE_MARGIN
        anchors.fill: parent
        Label{
            id: omniBarSensorLabel
            anchors.verticalCenter: parent.verticalCenter
            Behavior on color {ColorAnimation {}}
            anchors.rightMargin: _RES.s_MARGIN
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
        MouseArea{
            anchors.fill: parent
            enabled: parent.opacity === 1
        }
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

        Flickable{
            id: omniBarTrayFlickable
            flickableDirection: Flickable.VerticalFlick
            anchors.fill: parent
            contentHeight: filterBarTrayColumn.height
            interactive: false
            Column{
                id: filterBarTrayColumn
                anchors.left: parent.left
                anchors.right: parent.right
    //            anchors.bottom: omniBar.fillHeight? parent.bottom : undefined
                spacing: 0
            //OmniBar contents go here >>>
            }
        }


    }

    function computeHeight() {
        var barCoord = Utilities.getGlobalCoordinates(omniBar),
            fullHeight = app.height - ( barCoord.y + omniBar.height ),
            trayHeight = fillHeight? fullHeight : Math.min( fullHeight, filterBarTrayColumn.height );
        if (trayHeight === fullHeight) omniBarTrayFlickable.interactive = true;
        else  omniBarTrayFlickable.interactive = false;
        return trayHeight;
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
                height: computeHeight()
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
