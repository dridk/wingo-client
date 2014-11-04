import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

Rectangle{
    id: listItem
    //Needed for QtCreator design mode
    width: 540
    height: 48
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: textBox.text

    TextBox{
        id: textBox
        placeholder: "Search..."
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.bottomMargin: 8
        anchors.fill: parent

    }


    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
