import QtQuick 2.0

Image {
    id:root
    source:"http://appicns.com/appicns/svg/appicns_Photobooth.svg"
    sourceSize.width: width
    sourceSize.height: height
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

