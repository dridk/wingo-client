import QtQuick 2.0

import "../scripts/AppStyle.js" as Style


MouseArea {
    width: 32
    height: 32

    property string style: "DEFAULT"
//    property alias color: buttonBackground.color

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
