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
    height: Math.max(_RES.s_LIST_ITEM_DOUBLE_HEIGHT, textEntryBlock.height + _RES.s_TRIPPLE_MARGIN * 2.2)
    //-----------

    property alias text: textBoxEdit.text
    property alias placeholder: textBoxPlaceholder.text
    property alias textLength: textBoxEdit.length
    property int maxTextLength : -1
    property string action: ""

    function clear() {
        text = "";
    }

    signal actionPressed

    Item {
        id: textEntryBlockWrapper
        height: textBoxEdit.contentHeight
        anchors.right: actionBlockWrapper.left
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: _RES.s_DOUBLE_MARGIN
        anchors.rightMargin: _RES.s_MARGIN
        anchors.topMargin: _RES.s_TRIPPLE_MARGIN

        Rectangle{
            height: _RES.s_MARGIN

            color: Style.Background.WINDOW
            anchors.right: parent.right
            anchors.bottom: textEntryBlock.bottom
            anchors.left: parent.left
            anchors.bottomMargin: -_RES.s_BORDER
        }

        Rectangle{
            id: textEntryBlock
            height: textBoxEdit.contentHeight

            color: Style.Background.VIEW
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.rightMargin: _RES.s_BORDER
            anchors.leftMargin: _RES.s_BORDER

            TextEdit {
                id: textBoxEdit
                font.pixelSize: _RES.s_TEXT_SIZE_MEDIUM
                textFormat: Text.PlainText
                font.family: "Droid Sans"
                verticalAlignment: Text.AlignVCenter
                color: Style.Typography.TEXT
                wrapMode: TextEdit.Wrap
                anchors.bottomMargin: _RES.s_MARGIN
                anchors.rightMargin: _RES.s_MARGIN
                anchors.leftMargin: _RES.s_MARGIN
                anchors.fill: parent
                //focus: entryBox.focus
//                activeFocusOnPress: true
                selectByMouse: true
                selectionColor: Style.Background.SELECTION
                selectedTextColor: Style.Typography.SELECTION

                Label {
                    id: textBoxPlaceholder
                    anchors.bottom: parent.bottom
                    text: "Placeholder..."
                    color: Style.Typography.FADE
                    visible: !parent.focus && !parent.text.length
                }

            }
        }
    }
    Item {
        id: actionBlockWrapper
        anchors.top: textEntryBlockWrapper.top
        anchors.bottom: textEntryBlockWrapper.bottom
        anchors.right: parent.right
        anchors.rightMargin: _RES.s_DOUBLE_MARGIN
        width: entryBox.action == ""? 0 : actionButton.width

        Button {
            id: actionButton
            anchors.centerIn: parent
            icon: entryBox.action
            visible: entryBox.action !== ""
            enabled: textBoxEdit.text.length
            opacity: enabled? 1: 0.5
            onClicked: entryBox.actionPressed()
        }
    }

    Label {
        id: wordCount
        anchors.right: textEntryBlockWrapper.right
        anchors.top: textEntryBlockWrapper.bottom
        anchors.topMargin: _RES.s_MARGIN
        font.pixelSize: _RES.s_TEXT_SIZE_SMALL
        color: textBoxEdit.length < entryBox.maxTextLength? Style.Typography.ACCENT : Style.Typography.ALERT
        text: textBoxEdit.length
        visible: entryBox.maxTextLength !== -1
    }

}
