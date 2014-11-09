import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style

Item {
    id: checkmark
    width: _RES.s_LIST_ITEM_HEIGHT
    height: width

    property bool checked: false

    function toggle (state) {
        state = state || !checked;
        checked = state;
    }

    Rectangle {
        id: checkmarkBorder
        width: parent.width * 1.5
        height: width
        color: Style.Background.WINDOW
        border.color: Style.Border.DARK
        border.width: _RES.s_BORDER
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: checkmarkFill
            color: Style.Background.Button.ACTION
            visible: false
            anchors.rightMargin: _RES.s_BORDER * 2
            anchors.leftMargin: _RES.s_BORDER * 2
            anchors.bottomMargin: _RES.s_BORDER * 2
            anchors.topMargin: _RES.s_BORDER * 2
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
