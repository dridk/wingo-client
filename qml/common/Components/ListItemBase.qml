import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style


Item {
    anchors.fill: parent
    Rectangle{
        height: _RES.s_BORDER
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
