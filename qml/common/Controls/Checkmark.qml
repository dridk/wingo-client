import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style

Item {
    id: checkmark
    width: 48
    height: 48

    property bool checked: false

    function toggle (state) {
        state = state || !checked;
        checked = state;
    }

    Rectangle {
        id: checkmarkBorder
        width: 32
        height: 32
        color: Style.Background.WINDOW
        border.color: Style.Border.DARK
        border.width: 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: checkmarkFill
            color: Style.Background.Button.ACTION
            visible: false
            anchors.rightMargin: 4
            anchors.leftMargin: 4
            anchors.bottomMargin: 4
            anchors.topMargin: 4
            anchors.fill: parent
        }

    }

    MouseArea {
        anchors.fill: parent
        onClicked: toggle()
    }

    states: [
        State {
            name: "CHECKED"
            when: checked

            PropertyChanges {
                target: checkmarkFill
                visible: true
            }
        }
    ]
}
