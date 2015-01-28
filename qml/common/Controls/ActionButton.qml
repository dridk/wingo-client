import QtQuick 2.0
import QtGraphicalEffects 1.0
import Wingo 1.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../Components"

TouchSensorArea {
    id: button
    width: _RES.s_ACTION_BUTTON_SIZE
    height: width

    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.rightMargin: _RES.s_DOUBLE_MARGIN
    anchors.bottomMargin: _RES.s_DOUBLE_MARGIN

    property string style: "ACCENT"
    property alias icon: buttonIcon.name
    property bool hidden: false

    function toggle() {
        hidden = !hidden
    }

    function show() {
        hidden = false
    }

    function hide() {
        hidden = true
    }

//    Image{
//        id: buttonShadow
//        width: buttonContents.width + _RES.s_DOUBLE_MARGIN
//        height: buttonContents.height + parent.width * 0.12 + _RES.s_DOUBLE_MARGIN
//        source: "../../Res/images/actionButtonShadow.png"
//        anchors.centerIn: parent
//        anchors.verticalCenterOffset: _RES.s_MARGIN
//    }
    Image {
        id: buttonShadow
        width: buttonContents.width + _RES.s_TRIPPLE_MARGIN
        height: width
        anchors.centerIn: parent
        anchors.verticalCenterOffset: _RES.s_HALF_MARGIN
        source: "../../Res/images/shadowSquare.png"
    }

    CalloutRectangle {
        id: buttonContents
        anchors.fill: parent
        color: Style.Background.Button[button.style]

        tipHorizontalAlignment: Style.CALLOUT_RIGHT
        tipVerticalAlignment: Style.CALLOUT_BOTTOM_DOMINANAT

        Icon {
            id: buttonIcon
            anchors.centerIn: parent
            color: Style.Typography.Button[button.style]
            name: Icons.LOGO
            size: _RES.s_ICON_SIZE_BIG
        }
    }

    states: [
        State {
            name: "HIDDEN"
            when: hidden
            PropertyChanges {
                target: button
                anchors.bottomMargin: -buttonShadow.height
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "anchors.bottomMargin"; easing.type: Easing.InOutQuad }
    }

}
