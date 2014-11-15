import QtQuick 2.0
import QtQuick.Layouts 1.1

ListView {
    id: noteList
    Layout.fillWidth: true
    Layout.fillHeight: true
    clip: true
    delegate: NoteListItem{}

    property real triggerAnDistance: 50
    property int refreshTimeout: 2000

    property bool verticalMovementUp: verticalVelocity < 0
    property bool verticalMovementDown: verticalVelocity > 0
    property bool contentOverTopBound: contentY < 0
    property real contentDistanceTraveled: 0

    boundsBehavior: Flickable.DragOverBounds

    property int _contentY0: 0
    onFlickStarted: {_contentY0 = contentY; contentDistanceTraveled = 0}
    onFlickEnded: {
        _contentY0 = contentY;
        if(timeoutTimer.running)timeoutTimer.stop();
    }

    signal distancePassed
    signal refresh

    onContentYChanged: {
        contentDistanceTraveled = Math.abs(_contentY0 - contentY);
        if(contentDistanceTraveled > triggerAnDistance) distancePassed();
    }

    Timer{
        id: timeoutTimer
        interval: parent.refreshTimeout
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: parent.refresh()
        function toggle(){
            if (noteList.contentOverTopBound) timeoutTimer.restart();
        }

        Component.onCompleted: noteList.contentOverTopBoundChanged.connect(toggle)
    }
}
