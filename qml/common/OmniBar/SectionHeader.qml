import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

Rectangle {
    id: sectionHeader
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_LIST_ITEM_HEIGHT
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    color: Style.Background.WINDOW

    property alias text: sectionHeaderText.text

    Label{id: sectionHeaderText ; anchors.left: parent.left; anchors.leftMargin: _RES.s_DOUBLE_MARGIN;anchors.verticalCenter: parent.verticalCenter}

    Rectangle{
        height: _RES.s_BORDER
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DARK
    }
}
