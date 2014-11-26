import QtQuick 2.3

Rectangle {
    id:root
    width: 360
    height: 360

    property double latitude:48.408123
    property double longitude:-4.4995519
    property double zoom : 15


    Flickable {
        id:flickable
        anchors.fill: parent
        contentWidth: 500
        contentHeight: 500
        boundsBehavior: Flickable.StopAtBounds
        contentX: (contentWidth - root.width)/2
        contentY: (contentHeight - root.height)/2
        clip: true

        Image {




        }


        Image {
            id:pin
            source: "pin.png"
            anchors.centerIn: flickable
            anchors.verticalCenterOffset: -20
            opacity: 0.5
        }
    }

}

