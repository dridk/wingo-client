import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

Button{
    id: listItem
    //Needed for QtCreator design mode
    width: 540
    height: 96
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: listItemLabel.text
    property alias icon: listItemIcon.name

    Row{
        spacing: 8
        anchors.rightMargin: 16
        anchors.leftMargin: 16
        anchors.fill: parent

        Icon {
            id: listItemIcon
            name: ""
            anchors.verticalCenter: parent.verticalCenter
            visible: name !== ""
        }

        Label{
            id: listItemLabel
            text: "test"
            anchors.verticalCenter: parent.verticalCenter
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
