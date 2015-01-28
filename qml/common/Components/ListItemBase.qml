import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

Item {
    width: 560
    height: 96
    Rectangle{
        id: border
        height: _RES.s_BORDER
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
