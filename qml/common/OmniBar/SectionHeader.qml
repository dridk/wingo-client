import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../Controls" as Widgets

Rectangle {
    id: sectionHeader
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_LIST_ITEM_HEIGHT || 48
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    color: Style.Border.DEFAULT

    property alias text: sectionHeaderText.text

    Widgets.Label {
        id: sectionHeaderText
        anchors.left: parent.left
        anchors.leftMargin: _RES.s_DOUBLE_MARGIN
        anchors.verticalCenter: parent.verticalCenter
//        color: Style.Typography.FADE
        font.pixelSize: _RES.s_TEXT_SIZE_SMALL
    }
}
