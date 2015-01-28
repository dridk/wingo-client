import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

MouseArea
{
    enabled: false
    default property alias _contentChildren: background.data

    Rectangle{
        id: background
        color: Style.Background.OVERLAY
        anchors.fill: parent
        opacity: parent.enabled? 1 : 0
        Behavior on opacity {NumberAnimation{}}
    }
}
