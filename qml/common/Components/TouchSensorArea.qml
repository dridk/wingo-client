import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

MouseArea {
    Rectangle {
        id: shader
        anchors.fill: parent
        color: Style.Background.Button.PRESSED
        opacity: 0
        z: 99 //Keep this over all other components in the stack
        Behavior on opacity {NumberAnimation{}}
    }
    states: [
        State {
            name: "PRESSED"
            when: pressed
            PropertyChanges {
                target: shader
                opacity: 1
            }
        }
    ]
}
