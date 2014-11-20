import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style

Rectangle {
    id: indicator
    width: _RES.s_ICON_SIZE
    height: width
    radius: width / 2
    color: Style.Background.WINDOW

    property int progress: 0
    property alias timeout: indicatorTimer.interval
    property bool running: false
    property int lineWidth: _RES.s_MARGIN
    property color lineColorTimeout: Style.Palette.SUNRISE
    property color lineColorProgress: Style.Palette.SUNRISE


    signal timeoutTriggered

    Canvas{
        id: indicatorProgress
        anchors.fill: parent
//        anchors.margins: _RES.s_MARGIN
        antialiasing: true
        property real progress: 0
        property real pprogress: 0
        onPaint:{
            var l = indicator.lineWidth,
                w = indicatorProgress.width,
                h = indicatorProgress.height,
                r = (w - l * 2) / 2,
                p = Math.PI * progress,
                pp = Math.PI * indicator.progress * 0.01;
           var ctx = indicatorProgress.getContext('2d');

            ctx.save();
            ctx.clearRect(0, 0, w, h);

            ctx.strokeStyle = indicator.lineColorTimeout;
            ctx.lineWidth = indicator.lineWidth;
            ctx.beginPath();
            ctx.arc(r + l, r + l, r, 0, p, true);
            ctx.stroke();
            ctx.restore();
        }
        onProgressChanged: requestPaint()

        NumberAnimation on progress {
            id: indicatorProgressAnimation
            running: false
            duration: indicatorTimer.interval
            from: 0
            to: 2
        }

    }

    Icon{
        name: Icons.REFRESH
        anchors.centerIn: parent
        anchors.verticalCenterOffset: _RES.scale(2)
        size: _RES.s_ICON_SIZE_SMALL
        color: Style.Icon.SIDELINE
    }

    Timer{
        id: indicatorTimer
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: indicator.timeoutTriggered()
        function toggle(){
            if (indicator.running) {
                indicatorProgressAnimation.restart();
                indicatorTimer.restart();
            }else{
                indicatorProgressAnimation.stop();
                indicatorTimer.stop();
            }
        }

        Component.onCompleted: indicator.runningChanged.connect(toggle)
    }
}
