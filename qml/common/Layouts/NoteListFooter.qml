import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style

import "../Components" as Componenets
import "../Controls" as Widgets

Componenets.TouchSensorArea {
//    color: Style.Background.WINDOW

    anchors.left: parent.left
    anchors.right: parent.right
    height: _RES.s_ICON_SIZE_BIG

    property alias text: footerText.text

    Widgets.Label{
        id: footerText
        color: Style.Typography.QUOTE
        anchors.centerIn: parent
        text: "..."
    }
}

