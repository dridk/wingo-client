import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

MouseArea
{
//    anchors.fill: parent
    enabled: false
    Rectangle{
        color: Style.Background.OVERLAY
        anchors.fill: parent
        opacity: parent.enabled? 1 : 0
        Behavior on opacity {NumberAnimation{}}
    }
}
