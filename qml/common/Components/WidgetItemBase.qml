import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

Rectangle {
    property bool outerShadow: true
    color: Style.Background.VIEW
    Image{
        height: _RES.scale(4)
        source: "../../Res/images/shadow.png"
        anchors.top: parent.bottom
        anchors.topMargin: parent.outerShadow? 0 : -height
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
