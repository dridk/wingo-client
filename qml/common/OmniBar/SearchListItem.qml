import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

Rectangle{
    id: listItem
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_LIST_ITEM_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: textBox.text

    TextBox{
        id: textBox
        placeholder: "Search..."
        anchors.rightMargin: _RES.s_MARGIN
        anchors.leftMargin: _RES.s_MARGIN
        anchors.bottomMargin: _RES.s_MARGIN
        anchors.fill: parent

    }


    Rectangle{
        height: _RES.s_BORDER
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
