import QtQuick 2.0

import "../Controls" as Widgets
import "../../scripts/AppStyle.js" as Style

Rectangle {
    id: toast
    color: Style.Background.OVERLAY
    width: childrenRect.width + _RES.s_DOUBLE_MARGIN
    height: childrenRect.height + _RES.s_MARGIN
    property alias text: label.text
    property alias timeout: timeoutTimer.interval
    property alias running: timeoutTimer.running

    Component.onCompleted: state = "OPEN"

    opacity: 0

    Widgets.Label {
        id: label
        x: _RES.s_MARGIN
        y: _RES.s_MARGIN / 2
        color: Style.Typography.ACCENT
    }

    Timer {
        id: timeoutTimer
        onTriggered: toast.state = "CLOSE"
    }

    states:[
        State{
            name: ""
            PropertyChanges {
                target: toast
                opacity: 0
            }

        },
        State {
            name: "OPEN"
            PropertyChanges {
                target: toast
                opacity: 1
            }
        },
        State {
            name: "CLOSE"
            PropertyChanges {
                target: toast
                opacity: 0
            }
        }

    ]

    transitions: [
        Transition {
            from: ""
            to: "OPEN"
            NumberAnimation{target: toast}
        },
        Transition {
            from: "OPEN"
            to: "CLOSE"
            SequentialAnimation{
                NumberAnimation { target: toast;}
                ScriptAction{script: toast.destroy()}
            }
        }
    ]

}
