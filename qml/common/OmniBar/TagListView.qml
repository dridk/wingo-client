import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../Components" as Components
import "../Controls" as Widgets
import "../Layouts" as Layouts

Flow {
    id: tagListView
    spacing: _RES.s_DOUBLE_MARGIN
    anchors.left: parent.left
    anchors.leftMargin: spacing
    anchors.right: parent.right
    anchors.rightMargin: spacing

    property alias model: tagList.model
    signal click (int index, string tag)
    property alias emptyText: emptyTextLabel.text

    Item {
        width: parent.width
        height: _RES.s_MARGIN
    }

    Widgets.Label{
        id: emptyTextLabel
        text: "Looking for tags around you..."
        visible: parent.model.count === 0
    }

    Repeater {
        id: tagList
        Widgets.TagItem {
            style: "DISABLED"
            text: name + " (" +count+ ")"
            Components.TouchSensorArea{
                anchors.fill: parent
                onClicked: tagListView.click(index, name)
            }
        }
    }
}

//Column {
//    id: tagListView
//    //Needed for QtCreator design mode
//    width: 540
////    height: _RES.s_LIST_ITEM_DOUBLE_HEIGHT * 2
//    //-----------
//    anchors.left: parent.left
//    anchors.right: parent.right

//    property alias model: tagListViewRepeater.model

//    signal click (int index, string tag)

//    Repeater{
//        id: tagListViewRepeater
//        anchors.left: parent.left
//        anchors.right: parent.right
//        delegate: Components.TouchSensorArea {
//            height: _RES.s_LIST_ITEM_HEIGHT
//            anchors.left: tagListView.left
//            anchors.right: tagListView.right

//            Components.ListItemBase {
//                anchors.fill: parent
//                Row{
//                    anchors.fill: parent
//                    anchors.leftMargin: _RES.s_DOUBLE_MARGIN
//                    anchors.rightMargin: _RES.s_DOUBLE_MARGIN
//                    spacing: _RES.s_BASE_UNIT

//                    Widgets.Label{
//                        anchors.verticalCenter: parent.verticalCenter
//                        text: name
//                        color: Style.Typography.LINK
//                    }

//                    Widgets.Label{
//                        anchors.verticalCenter: parent.verticalCenter
//                        text: " - " + count
//                        color: Style.Typography.ACCENT
//                    }

//                }
//            }

//            onClicked: tagListView.click (index, name)
//        }
//    }
//}
