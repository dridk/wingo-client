import QtQuick 2.3
import "../scripts/AppStyle.js" as Style

Item {
    width: parent.width
    height: maxNoteLength

    property int maxNoteLength : 255
    property string _temp

    Rectangle {
        id:container
        width: parent.width
        height:(txtId.lineCount * 32) + 10
        color: "white"
        TextEdit {
            id:txtId
            anchors.fill: parent
            anchors.margins: 10
            wrapMode:TextEdit.Wrap
            font.pointSize: 16
            textFormat: Text.RichText
            font.family: "Droid Sans"
            color: Style.Typography.TEXT
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
            cursorVisible: true
            text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris commodo dolor sed risus tristique, ac congue velit faucibus. Integer ultrices in sapien scelerisque accumsan. Integer faucibus non velit nec vulputate. Lorem ipsum dolor sit amet turpis duis."

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
        height:40
        color: "white"

        Rectangle {
            anchors.top: parent.top
            width: parent.width
            height: 1
            color: "#00b8cc"

        }

        Text {
            id:limitId
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 5
            text: "( "+txtId.length+" )"
            font.pointSize: 16
            textFormat: Text.RichText
            font.family: "Droid Sans"
            color: txtId.length >=255 ? "red" : Style.Typography.FADE

        }




    }


}
