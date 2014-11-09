import QtQuick 2.3
import "../scripts/AppStyle.js" as Style

Item {
    width: parent.width
    height: maxNoteLength

    property int maxNoteLength : 255
    property alias text : txtId.text
    property string _temp

    Rectangle {
        id:container
        width: parent.width
        height: txtId.contentHeight + txtId.font.pixelSize

        color: "white"
        TextEdit {
            id:txtId
            anchors.fill: parent
            anchors.margins: _RES.s_MARGIN
            wrapMode:TextEdit.Wrap
            font.pixelSize: _RES.s_TEXT_SIZE_MEDIUM
            textFormat: Text.PlainText
            font.family: "Droid Sans"
            color: Style.Typography.TEXT
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
            cursorVisible: true
            text:"Write your note here"
            selectByMouse: true

            Component.onCompleted: {
                console.debug("?"+txtId.height)
                txtId.selectAll()
            }


            onTextChanged: {
               // Limit text length
                if (length > 255){
                    text = _temp
                    limitAnimation.start()
                }
                else
                    _temp = text
            }

        }
    }

    Rectangle {
        id:footer
        width: parent.width
        anchors.top: container.bottom
        height: _RES.s_LIST_ITEM_HEIGHT
        color: "white"

        Rectangle {
            anchors.top: parent.top
            width: parent.width
            height: _RES.s_BORDER
            color: "#00b8cc"
        }

        Label {
            id:limitId
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: _RES.s_MARGIN
            text: "( "+txtId.length+" )"
            font.pixelSize: _RES.s_TEXT_SIZE_SMALL
            color: txtId.length >=255 ? "red" : Style.Typography.FADE

        }




    }


}
