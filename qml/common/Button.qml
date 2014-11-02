import QtQuick 2.0

MouseArea {
    width: 32
    height: 32
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0,0,0,0.5)
        opacity: parent.pressed? 1: 0
        Behavior on opacity {NumberAnimation{}}
    }
}
