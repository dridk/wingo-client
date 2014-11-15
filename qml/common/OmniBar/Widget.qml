import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../../scripts/AppStyle.js" as Style
import "../../scripts/Icons.js" as Icon
import "../../scripts/Utilities.js" as Utilities
import "../Components" as Components
import "../Controls" as Widgets

Item {
    id: omniBar
    default property alias _contentChildren: filterBarTrayColumn.data
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_OMNI_BAR_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: omniBarSensorLabel.text
    property alias icon: omniBarSensorIcon.name
    property bool animateIconOnexpand: true
    property bool expanded: omniBarTray.height > 0
    property bool fillHeight: false
    z: 99

    signal expand
    signal contract

    function show() {
        state = ""
    }

    function hide() {
        state = "HIDDEN"
    }

    function toggleTray() {
        if (state == "EXPANDED")
            contractTray()
        else
            expandTray()
    }

    function expandTray() {
        if (state === "EXPANDED") return;
        state = "EXPANDED"
        expand()
    }

    function contractTray() {
        if (state === "") return;
        state = ""
        omniBarTrayFlickable.contentY = 0
        contract()
    }

    Components.WidgetItemBase {
        id: omniBarWidget
        anchors.fill: parent
        z: 2
        MouseArea {
            id: omniBarSensor
            anchors.fill: parent
            Widgets.Label {
                id: omniBarSensorLabel
                anchors.verticalCenter: parent.verticalCenter
                Behavior on color {
                    ColorAnimation {
                    }
                }
                anchors.rightMargin: _RES.s_MARGIN
                anchors.right: omniBarSensorShape.left
                anchors.left: parent.left
                anchors.leftMargin: _RES.s_DOUBLE_MARGIN
                elide: Text.ElideRight
            }
            Components.Trapezoid {
                id: omniBarSensorShape
                width: _RES.scale(80)
                height: parent.height
                anchors.right: parent.right
                color: Style.Background.WINDOW
                Widgets.Icon {
                    id: omniBarSensorIcon
                    name: Icon.CARRET_DOWN
                    anchors.right: parent.right
                    anchors.rightMargin: _RES.s_MARGIN
                    anchors.verticalCenter: parent.verticalCenter
                    Behavior on rotation {
                        NumberAnimation {
                        }
                    }
                    Behavior on color {
                        ColorAnimation {
                        }
                    }
                }
            }
            onClicked: toggleTray()
        }
    }

    //Page shadowing effect
    Components.OverlayBackground {
        id: overlay
        z: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: app.height - (omniBar.y + omniBar.height)
    }

    Components.WidgetItemBase {
        id: omniBarTray
        z: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: 0
        clip: true
        color: Style.Background.VIEW
        Behavior on height {
            NumberAnimation {
                easing.type: Easing.InOutQuad
            }
        }

        Flickable {
            id: omniBarTrayFlickable
            flickableDirection: Flickable.VerticalFlick
            anchors.topMargin: _RES.s_DOUBLE_MARGIN
            anchors.bottomMargin: _RES.s_DOUBLE_MARGIN
            anchors.fill: parent
            contentHeight: filterBarTrayColumn.height
            interactive: false
            Column {
                id: filterBarTrayColumn
                anchors.left: parent.left
                anchors.right: parent.right
                //            anchors.bottom: omniBar.fillHeight? parent.bottom : undefined
                spacing: 0
                //OmniBar contents go here >>>
            }
        }
    }

    MouseArea {
        id: omniBarFiller
        //This is needed to make sure we get clicks outside the tray area
        enabled: omniBar.expanded
        height: 0
        y: -height
        anchors.left: parent.left
        anchors.right: parent.right
        onClicked: omniBar.contractTray()
    }

    function _computeY() {
        var barCoord = Utilities.getGlobalCoordinates(omniBar)
        return barCoord.y
    }

    function _computeHeight() {
        var fullHeight = app.height  - (_computeY() + omniBar.height),
            trayHeight = fillHeight ? fullHeight : Math.min(fullHeight, filterBarTrayColumn.height)
        if (trayHeight === fullHeight)
            omniBarTrayFlickable.interactive = true
        else
            omniBarTrayFlickable.interactive = false
        return trayHeight
    }

    states: [
        State {
            name: "EXPANDED"

            PropertyChanges {
                target: omniBarSensorIcon
                rotation: animateIconOnexpand ? 180 : 0
                color: Style.Icon.FADE
            }

            PropertyChanges {
                target: omniBarTray
                height: _computeHeight()
            }
            PropertyChanges {
                target: omniBarFiller
                height: _computeY()
            }

            PropertyChanges {
                target: overlay
                enabled: true
            }

            PropertyChanges {
                target: omniBarSensorLabel
                color: Style.Typography.FADE
            }
        },
        State {
            name: "HIDDEN"

            PropertyChanges {
                target: omniBar
                clip: true
                height: 0
//                opacity: 0
            }
            PropertyChanges {
                target: omniBarSensor
                enabled: false
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {target: omniBar; properties: "height, opacity"; easing.type: Easing.InOutQuad }
    }
}
