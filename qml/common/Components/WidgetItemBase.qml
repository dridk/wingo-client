import QtQuick 2.0
import "../../scripts/AppStyle.js" as Style

Rectangle {
    id: container
    property alias hasShadow: shadow.visible
    property bool outerShadow: true
    color: Style.Background.VIEW
    Image{
        id: shadow
        height: U.px(4)
        source: "../../Res/images/shadow.png"
        anchors.top: parent.bottom
        anchors.topMargin: parent.outerShadow? 0 : -height
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
