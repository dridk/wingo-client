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
    property color iconBackgroundColor: Style.Background.WINDOW
    property bool expanded: omniBarTray.height > 0
    property bool hidden: state == "HIDDEN"
    property bool fillHeight: false
    z: 99

    signal expand
    signal opened
    signal contract
    signal closed

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
        if (state === "EXPANDED")
            return
        Qt.inputMethod.hide() //Hide all input methods
        focus = true //Focus UI on self
        state = "EXPANDED"
    }

    function contractTray() {
        if (state === "")
            return
        focus = false //Return Focus
        state = ""
        omniBarTrayFlickable.contentY = 0
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
                width: U.px(80)
                height: parent.height
                anchors.right: parent.right
                color: omniBar.iconBackgroundColor
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

    Components.WidgetItemBase {
        id: omniBarTray
        z: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: 0
        clip: true
        color: Style.Background.VIEW
//        Behavior on height {
//            NumberAnimation {
//                easing.type: Easing.InOutQuad
//            }
//        }

        Components.Flickable {
            id: omniBarTrayFlickable
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
        Widgets.ScrollIndicator {
            attachTo: omniBarTrayFlickable
            showScrollBarWhen: omniBarTrayFlickable.movingVertically
        }
    }


    //Page shadowing effect
    Components.OverlayBackground {
        id: overlay
        z: 0
        anchors.left: parent.left
        anchors.right: parent.right
        height: app.height // - (omniBar.y + omniBar.height)
        onClicked: {
            if (!Utilities.isPointInRect(
                        Qt.point(mouse.x,mouse.y),
                        Qt.rect(omniBarTray.x, omniBarTray.y + (-y), omniBarTray.width, omniBarTray.height)))
               omniBar.contractTray();
        }
    }

    Component.onCompleted: overlay.y = -_computeY()

    function _computeY() {
        var barCoord = Utilities.getGlobalCoordinates(omniBar)
        return barCoord.y
    }

    function _computeHeight() {
        var fullHeight = app.height - (_computeY(
                                           ) + omniBar.height), trayHeight = fillHeight ? fullHeight : Math.min(fullHeight, (filterBarTrayColumn.height + omniBarTrayFlickable.anchors.topMargin + omniBarTrayFlickable.anchors.bottomMargin))
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

    transitions: [
        Transition {
            from: ""
            to: "EXPANDED"
            SequentialAnimation {
                ScriptAction{script: omniBar.expand()}
                NumberAnimation {
                    target: omniBarTray
                    property: "height"
                    easing.type: Easing.InOutQuad
                }
                ScriptAction{script: omniBar.opened()}
            }
        },
        Transition {
            from: "EXPANDED"
            to: ""
            SequentialAnimation {
                ScriptAction{script: omniBar.contract()}
                NumberAnimation {
                    target: omniBarTray
                    property: "height"
                    easing.type: Easing.InOutQuad
                }
                ScriptAction{script: omniBar.closed()}
            }
        },
        Transition {
            from: ""
            to: "HIDDEN"
            NumberAnimation {
                target: omniBar
                properties: "height, opacity"
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "HIDDEN"
            to: ""
            NumberAnimation {
                target: omniBar
                properties: "height, opacity"
                easing.type: Easing.InOutQuad
            }
        }
    ]
}
