import QtQuick 2.0

Image {
    id:root
    source:"qrc:/qml/Res/images/camera75.svg"
    sourceSize.width: width * scale
    sourceSize.height: height * scale
    scale : area.pressed ? 2 : 1
    signal clicked()


    Behavior on scale {
        NumberAnimation {
            easing.type: Easing.OutExpo
            duration : 1000
        }

    }


    MouseArea {
        id:area
        anchors.fill: parent
        onClicked: root.clicked()


    }

}

