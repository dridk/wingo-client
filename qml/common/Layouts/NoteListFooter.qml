import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style

import "../Components" as Componenets
import "../Controls" as Widgets

Componenets.TouchSensorArea {
//    color: Style.Background.WINDOW

    anchors.left: parent.left
    anchors.right: parent.right
    height: childrenRect.height + _RES.s_DOUBLE_MARGIN

    property alias text: footerText.text

    Widgets.Label{
        id: footerText
        color: Style.Typography.QUOTE
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.margins: _RES.s_DOUBLE_MARGIN
        text: "..."
    }
}

