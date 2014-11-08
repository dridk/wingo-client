import QtQuick 2.0
import "../scripts/AppStyle.js" as Style
Icon {

    property alias pressed : area.pressed
    signal clicked()

    MouseArea {
        id:area
        anchors.fill: parent
        onClicked: parent.clicked()
    }


    Rectangle {
        id: buttonBackground
        color: Style.Background.Button[style]
        anchors.fill: parent
    }

    Rectangle {
        id: buttonFeedbackShader
        anchors.fill: parent
        color: Qt.rgba(0,0,0,0.5)
        opacity: parent.pressed? 1: 0
        Behavior on opacity {NumberAnimation{}}
    }



}
