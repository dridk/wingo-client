import QtQuick 2.0
import QtGraphicalEffects 1.0
import Wingo 1.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../Components"

WidgetItemBase {
    id: entryBox
    //Needed for QtCreator design mode
    width: 540
    height: 48
    //-----------

    property alias text: textBoxEdit.text
    property alias placeholder: textBoxPlaceholder.text

    Item{
        id: entryBlock
        Rectangle{
            height: _RES.s_MARGIN

            color: Style.Background.WINDOW
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
        }

        Rectangle{
            height: (textBoxEdit.lineCount + 1) * textBoxEdit.font.pixelSize

            color: Style.Background.VIEW
            anchors.rightMargin: _RES.s_BORDER
            anchors.leftMargin: _RES.s_BORDER
            anchors.bottomMargin: _RES.s_BORDER
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

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
                focus: textBox.focus
                activeFocusOnPress: true

                Label{
                    id: textBoxPlaceholder
                    anchors.bottomMargin: _RES.s_MARGIN
                    anchors.leftMargin: _RES.s_MARGIN
                    text: "Placeholder..."
                    color: Style.Typography.FADE
                    visible: !parent.text
                }

            }
        }
    }
    Label{
        id: wordCount
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

}
