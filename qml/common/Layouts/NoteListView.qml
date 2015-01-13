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

    property real triggerAnDistance: height * 0.2
    property bool refreshOnPull: true
    property int refreshTimeout: 1000

    property bool verticalMovementUp: verticalVelocity < 0
    property bool verticalMovementDown: verticalVelocity > 0
    property bool contentOverTopBound: contentY < 0
    property bool contentOverBottomBound: contentY > contentHeight
    property real contentDistanceTraveled: 0

    property alias busy: timeoutTimer.busy

    boundsBehavior: Flickable.DragOverBounds

    property int _contentY0: 0
    onFlickStarted: {
        _contentY0 = contentY
        contentDistanceTraveled = 0
    }

    signal distancePassed
    signal refresh

    onContentYChanged: {
        contentDistanceTraveled = Math.abs(_contentY0 - contentY)
        if (contentDistanceTraveled > triggerAnDistance)
            distancePassed()
    }

    Widgets.ScrollIndicator {
        contentHeight: parent.contentHeight
        contentPosition: parent.contentY
//        opacity: parent.flicking? 1: 0
//        Behavior on opacity { NumberAnimation{duration: 1000} }
    }

    Widgets.LoadingIndicator {
        id: timeoutTimer
        y: ((refreshOnPull&&noteList.contentOverTopBound)
            ||busy) ? _RES.s_MARGIN : -height
        anchors.horizontalCenter: parent.horizontalCenter
        running: refreshOnPull && noteList.contentOverTopBound
        timeout: parent.refreshTimeout
        onTimeoutTriggered: parent.refresh()

        Behavior on y {
            NumberAnimation {
            }
        }
    }
}
