import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

ListView {
    id: tagListView
    //Needed for QtCreator design mode
    width: 540
    height: 100
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    clip:true

    signal click (int index, string tag)

    delegate: Button {
        height: 48
        anchors.left: parent.left
        anchors.right: parent.right

        Row{
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            spacing: 8

            Label{
                anchors.verticalCenter: parent.verticalCenter
                text: name
                color: Style.Typography.ACCENT
            }

            Label{
                anchors.verticalCenter: parent.verticalCenter
                text: " - " + count
                color: Style.Typography.FADE
            }

        }

        onClicked: tagListView.click (index, tag)

        Rectangle{
            height: 2
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: Style.Border.DEFAULT
        }
    }
}
