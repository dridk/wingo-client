import QtQuick 2.0

import "../scripts/AppStyle.js" as Style

Button{
    id: listItem
    //Needed for QtCreator design mode
    width: 540
    height: 48
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: listItemLabel.text

    Label{
        id: listItemLabel
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 16
    }
    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
