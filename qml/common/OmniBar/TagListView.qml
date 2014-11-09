import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

Column {
    id: tagListView
    //Needed for QtCreator design mode
    width: 540
//    height: _RES.s_LIST_ITEM_DOUBLE_HEIGHT * 2
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias model: tagListViewRepeater.model

    signal click (int index, string tag)

    Repeater{
        id: tagListViewRepeater
        anchors.left: parent.left
        anchors.right: parent.right
        delegate: Button {
            height: _RES.s_LIST_ITEM_HEIGHT
            anchors.left: tagListView.left
            anchors.right: tagListView.right

            Row{
                anchors.fill: parent
                anchors.leftMargin: _RES.s_DOUBLE_MARGIN
                anchors.rightMargin: _RES.s_DOUBLE_MARGIN
                spacing: _RES.s_BASE_UNIT

                Label{
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: Style.Typography.LINK
                }

                Label{
                    anchors.verticalCenter: parent.verticalCenter
                    text: " - " + count
                    color: Style.Typography.ACCENT
                }

            }

            onClicked: tagListView.click (index, name)

            Rectangle{
                height: _RES.s_BORDER
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                color: Style.Border.DEFAULT
            }
        }
    }
}
