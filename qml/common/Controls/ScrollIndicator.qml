import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style

Item {
    id: scrollBarContainer
    width: _RES.s_MARGIN

    property var attachTo: parent

    anchors.top: attachTo.top
    anchors.bottom: attachTo.bottom
    anchors.right: attachTo.right

    property int contentHeight: attachTo.contentHeight - height
    property int contentPosition: attachTo.contentY

    property bool alwaysOn: false
    property bool showScrollBarWhen: false

    Rectangle {
        id: scrollBar
        property real relativePosition: parent.contentPosition / parent.contentHeight
        property real adjustedHeight: parent.height - height - _RES.s_DOUBLE_MARGIN

        y: adjustedHeight * relativePosition + _RES.s_MARGIN
        width: _RES.s_HALF_MARGIN
        height: _RES.s_ICON_SIZE
        anchors.horizontalCenter: parent.horizontalCenter
        color: Style.Background.OVERLAY
        opacity: parent.alwaysOn? 1: 0

    }

    states: [
        State{
            name: "SHOW"
            when: alwaysOn || showScrollBarWhen
            PropertyChanges {
                target: scrollBar
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "SHOW"
            NumberAnimation{
                property: "opacity"
                duration:100
            }
        },
        Transition {
            from: "SHOW"
            to: ""
            SequentialAnimation{

                PauseAnimation {
                    duration: 800
                }
                NumberAnimation{
                    property: "opacity";
                    duration: 500
                }
            }
        }
    ]

}

