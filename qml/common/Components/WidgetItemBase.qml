import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

Rectangle {
    color: Style.Background.VIEW
    Image{
        height: _RES.scale(4)
        source: "../../Res/images/shadow.png"
        anchors.top: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
