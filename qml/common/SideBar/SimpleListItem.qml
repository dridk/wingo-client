import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../Components" as Components
import "../Controls" as Widgets

Components.TouchSensorArea{
    id: listItem
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_LIST_ITEM_DOUBLE_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: listItemLabel.text
    property alias icon: listItemIcon.name
    opacity: enabled ? 1 : 0.2

    Widgets.Icon {
        id: listItemIcon
        name: ""
        size: _RES.s_ICON_SIZE_SMALL
        color: Style.Icon.SIDELINE
        anchors.left: parent.left
        anchors.leftMargin: _RES.s_HALF_DOUBLE_MARGIN
        anchors.verticalCenter: parent.verticalCenter
        visible: name !== ""
    }

    Widgets.Label{
        id: listItemLabel
        text: "test"
        anchors.left: parent.left
        anchors.leftMargin: U.px(72)
        anchors.verticalCenter: parent.verticalCenter
    }
}
