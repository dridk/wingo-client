import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../Controls" as Widgets
import "../Components" as Components
import "../../scripts/AppStyle.js" as Style
import "../../scripts/Utilities.js" as Utilities

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
        if (state === "EXPANDED") return;
        Qt.inputMethod.hide(); //Hide all input methods
        focus = true;  //Focus UI on self
        state = "EXPANDED";
        expand();
    }

    function contractTray(){
        if (state === "") return;
        focus = false;  //Return Focus
        state = ""
        contract()
    }

    // Block click throughts

    //Page shadowing effect
    Components.OverlayBackground {
        id: overlay
        z: 0
        anchors.fill: parent
        onClicked: {
            if ( !Utilities.isPointInRect(
                        Qt.point(mouse.x,mouse.y),
                        Qt.rect(0,0,sideBarTray.width,sideBarTray.height)))
            sideBar.contractTray();
        }
    }
//    Rectangle
//    {
//        id: overlay
//        color: Style.Background.OVERLAY
//        anchors.fill: parent
//        opacity: 0
//        Behavior on opacity {NumberAnimation{}}
//        MouseArea{anchors.fill: parent; enabled: parent.opacity > 0; onClicked: sideBar.contractTray()}
//    }

    Rectangle{
        id: sideBarTray
        width: parent.width * 0.8
        height: parent.height
        color: Style.Background.VIEW
        x: -width
        Behavior on x {NumberAnimation{easing.type: Easing.InOutQuad }}

        Components.Flickable{
            id: sideBarTrayFlickable
            anchors.fill: parent
            contentHeight: sideBarTrayColumn.height
            interactive: height < contentHeight

            ColumnLayout{
                id: sideBarTrayColumn
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 0
            }
        }
        Widgets.ScrollIndicator {
            attachTo: sideBarTrayFlickable
            showScrollBarWhen: sideBarTrayFlickable.movingVertically
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
                enabled: true
            }
        }
    ]

}
