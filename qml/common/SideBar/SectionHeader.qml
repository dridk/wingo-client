import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../Controls" as Widgets

Item {
    id: sectionHeader
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_LIST_ITEM_HEIGHT || 48
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    property alias text: sectionHeaderText.text

    Rectangle{
        height: _RES.s_BORDER
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }

    Widgets.Label {
        id: sectionHeaderText
        anchors.left: parent.left
        anchors.leftMargin: _RES.s_TRIPPLE_MARGIN
        anchors.verticalCenter: parent.verticalCenter
        color: Style.Typography.FADE
        font.pixelSize: _RES.s_TEXT_SIZE_SMALL
    }
}
