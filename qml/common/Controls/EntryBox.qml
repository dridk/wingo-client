import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../../scripts/Icons.js" as Icons
import "../Components" as Componenets

Item {
    id: entryBox
    //Needed for QtCreator design mode
    width: 540
    height: _RES.s_LIST_ITEM_HEIGHT
    //-----------

    property alias text: textBoxEdit.text
    property alias placeholder: textBoxPlaceholder.text
    property alias inputMethodHints : textBoxEdit.inputMethodHints

    Rectangle{
        height: _RES.s_MARGIN

        color: Style.Background.WINDOW
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    Rectangle{

        color: Style.Background.VIEW
        anchors.rightMargin: _RES.s_BORDER
        anchors.leftMargin: _RES.s_BORDER
        anchors.bottomMargin: _RES.s_BORDER
        anchors.fill: parent

        TextEdit{
            id: textBoxEdit
            font.pixelSize: _RES.s_TEXT_SIZE_MEDIUM || 24
            textFormat: Text.PlainText
            font.family: "Droid Sans"
            verticalAlignment: Text.AlignVCenter
            color: Style.Typography.TEXT
            anchors.bottomMargin: _RES.s_MARGIN
            anchors.rightMargin: _RES.s_MARGIN
            anchors.leftMargin: _RES.s_MARGIN
            anchors.fill: parent
            activeFocusOnPress: true

            Label{
                id: textBoxPlaceholder
                text: "Placeholder..."
                anchors.fill: parent
                color: Style.Typography.FADE
                visible: !parent.text
            }

        }

        Componenets.TouchSensorArea {
            height: parent.height
            width: height
            anchors.right: parent.right

            Icon{
                name: Icons.AXE
                size: _RES.s_ICON_SIZE_SMALL
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: entryBox.text === ""? Style.Icon.SUNKEN : Style.Icon.FADE
            }

            onClicked: entryBox.text = ""

        }
    }

}
