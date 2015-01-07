import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style

Item {
    id: container
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: _RES.s_DOUBLE_MARGIN
    height: frame.height + _RES.s_MARGIN

    property alias source: picture.source
    property alias fillMode: picture.fillMode
//    property bool name: value
    property bool showPlaceholder: false

    visible: showPlaceholder || picture.status !== Image.Null

    Rectangle {
        id: frame
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: _RES.s_MARGIN
        height: Math.max(picture.height + _RES.s_DOUBLE_MARGIN, _RES.s_ICON_SIZE_BIG)

        color: Style.Background.WINDOW
        radius: _RES.s_HALF_MARGIN

        Image {
            id: picture
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: _RES.s_MARGIN
            fillMode: Image.PreserveAspectFit
            onStatusChanged: if (status === Image.Error) app.makeToast("Error loading image", Style.MESSAGE_PURPOSE_ALERT)
            cache: true
        }

        Icon{
           name: Icons.PICTURE
           color: Style.Icon.SIDELINE
           size: _RES.s_ICON_SIZE_BIG
           anchors.centerIn: parent
           visible: picture.status !== Image.Ready

           SequentialAnimation on opacity {
               running: parent.visible
               loops: Animation.Infinite

               NumberAnimation {
                   to: 0.5
               }
               NumberAnimation {
                   to: 1
               }
           }
        }

//        LoadingIndicator{
//            id: loadingIndicator
//            anchors.centerIn: parent
//            busy: picture.status === Image.Loading
//            opacity: busy? 1 : 0
//            Behavior on opacity {NumberAnimation{}}
//        }
    }
}
