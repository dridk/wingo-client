import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

Rectangle{
    id: listItem
    //Needed for QtCreator design mode
    width: 540
    height: 96
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property int selected: -1
    property alias model: listItemRepeater.model

    signal click (int index, string value)

    Row{
        anchors.bottomMargin: 8
        anchors.topMargin: 8
        spacing: 0
//        anchors.rightMargin: 16
//        anchors.leftMargin: 16
        anchors.fill: parent

        Repeater {
            id: listItemRepeater
//            model: ["5m", "10m", "50m", "100m"]
            SelectArea {
                width: listItem.width / listItemRepeater.count
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                Rectangle{
                    width: 2
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    color: Style.Border.DEFAULT
                    visible: index > 0
                }

                Label{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData
                    color: listItem.selected === index ? Style.Typography.TEXT : Style.Typography.FADE
                }

                onClicked: {
                    listItem.selected = index
                    listItem.click(index, modelData)
                }
            }
        }
    }

    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
