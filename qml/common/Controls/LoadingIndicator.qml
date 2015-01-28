import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style

Rectangle {
    id: indicator
    width: _RES.s_ICON_SIZE
    height: width
    radius: width / 2
    color: Style.Background.WINDOW

    property bool busy: false
    property alias timeout: indicatorTimer.interval
    property bool running: false
    property int lineWidth: _RES.s_HALF_MARGIN
    property color lineColorTimeout: Style.Palette.SUNRISE
    property color lineColorBusy: Style.Palette.CYAN

    signal timeoutTriggered

    Canvas{
        id: indicatorProgress
        anchors.fill: parent
//        anchors.margins: _RES.s_MARGIN
        antialiasing: true
        property real progress: 0
        onPaint:{
            var l = indicator.lineWidth,
                w = indicatorProgress.width,
                h = indicatorProgress.height,
                r = (w - l * 3) / 2,
                p1 = progress >= 0? 0: Math.PI * progress,
                p2 = progress <= 0? 0: Math.PI * progress;
           var ctx = indicatorProgress.getContext('2d');

            ctx.save();
            ctx.clearRect(0, 0, w, h);
            ctx.translate(w/2, h/2)
            ctx.rotate(-Math.PI/2);

            ctx.strokeStyle = indicatorBusyAnimation.running? indicator.lineColorBusy : indicator.lineColorTimeout;
            ctx.lineWidth = indicator.lineWidth;
            ctx.beginPath();
            ctx.arc(0, 0, r, p1, p2, true);
            ctx.stroke();
            ctx.restore();
        }
        onProgressChanged: requestPaint()

        NumberAnimation on progress {
            id: indicatorProgressAnimation
            running: indicatorTimer.running
            duration: indicatorTimer.interval
            from: 0
            to: 2
        }

        SequentialAnimation on progress {
            id: indicatorBusyAnimation
            running: indicator.busy && !indicatorProgressAnimation.running
            loops: Animation.Infinite
            NumberAnimation{
                from: -2
                to: 0
                duration: 1000
            }
            NumberAnimation{
                from: 0
                to: 2
                duration: 1000
            }
        }

    }

    Icon{
        id: busyIndicator
        name: Icons.REFRESH
        anchors.centerIn: parent
        anchors.verticalCenterOffset: U.px(1)
        size: _RES.s_ICON_SIZE_SMALL
        color: Style.Icon.SIDELINE
//        Behavior on color{ColorAnimation{}}

    }

    Timer{
        id: indicatorTimer
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: indicator.timeoutTriggered()
        function toggle(){
            if (indicator.running) {
                indicatorTimer.restart();
            }else{
                indicatorTimer.stop();
            }
        }

        Component.onCompleted: indicator.runningChanged.connect(toggle)
    }

}
