import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

Rectangle {
    id: sectionHeader
    //Needed for QtCreator design mode
    width: 540
    height: 48
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    color: Style.Background.WINDOW

    property alias text: sectionHeaderText.text

    Label{id: sectionHeaderText ; anchors.left: parent.left; anchors.leftMargin: 16;anchors.verticalCenter: parent.verticalCenter}

    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DARK
    }
}
