import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    visible: true
    width: 540
    height: 960

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
}
