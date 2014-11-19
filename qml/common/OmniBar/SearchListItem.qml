import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../Components" as Componenets
import "../Controls" as Widgets

Item{
    id: listItem
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_LIST_ITEM_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: textBox.text

    Widgets.EntryBox{
        id: textBox
        placeholder: "Search..."
        anchors.rightMargin: _RES.s_DOUBLE_MARGIN
        anchors.leftMargin: _RES.s_DOUBLE_MARGIN
        anchors.bottomMargin: _RES.s_MARGIN
        anchors.fill: parent
    }

}
