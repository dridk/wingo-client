import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../Components" as Components
import "../Controls" as Widgets

Components.TouchSensorArea{
    id: listItem
    default property alias _contentChildren: listItemRow.data
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_LIST_ITEM_DOUBLE_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: listItemLabel.text
    property alias icon: listItemIcon.name

    Components.ListItemBase {
        anchors.fill: parent

        Row{
            id: listItemRow
            spacing: _RES.s_BASE_UNIT
            anchors.rightMargin: _RES.s_DOUBLE_MARGIN
            anchors.leftMargin: _RES.s_DOUBLE_MARGIN
            anchors.fill: parent

            Widgets.Icon {
                id: listItemIcon
                name: ""
                anchors.verticalCenter: parent.verticalCenter
                visible: name !== ""
            }

            Widgets.Label{
                id: listItemLabel
                text: "test"
                anchors.verticalCenter: parent.verticalCenter
            }

        }
    }
}
