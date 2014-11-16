import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../Controls" as Widgets

ListView {
    id: noteList
    Layout.fillWidth: true
    Layout.fillHeight: true
    anchors.left: parent.left
    anchors.right: parent.right
    clip: true
    delegate: NoteListItem{}

    property real triggerAnDistance: height * 0.2
    property int refreshTimeout: 2000

    property bool verticalMovementUp: verticalVelocity < 0
    property bool verticalMovementDown: verticalVelocity > 0
    property bool contentOverTopBound: contentY < 0
    property bool contentOverBottomBound: contentY > contentHeight
    property real contentDistanceTraveled: 0

    boundsBehavior: Flickable.DragOverBounds

    property int _contentY0: 0
    onFlickStarted: {_contentY0 = contentY; contentDistanceTraveled = 0}

    signal distancePassed
    signal refresh

    onContentYChanged: {
        contentDistanceTraveled = Math.abs(_contentY0 - contentY);
        if(contentDistanceTraveled > triggerAnDistance) distancePassed();
    }

//    add: Transition {
//            NumberAnimation { properties: "y"; from: noteList.height; duration: 300; easing: Easing.InOutQuad }
//        }

    Widgets.TimeoutIndicator {
        id: timeoutTimer
        y: noteList.contentOverTopBound? _RES.s_MARGIN : - height
        anchors.horizontalCenter: parent.horizontalCenter
        running: noteList.contentOverTopBound
        timeout: parent.refreshTimeout
        onTimeoutTriggered: parent.refresh()

        Behavior on y {NumberAnimation{}}
    }



}
