import QtQuick 2.3

import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../common"

Page {
    id: page

    icon: ""
    title: "Add Note"
    defaultAction: Style.ACTION_BAR_BACK_ACTION

    onBackButtonClicked: app.goBack()

    actionsListModel: ListModel{
        ListElement {
            icon: "post48"
            name: "post"
            buttonStyle: "ACCENT"
        }
    }

    OmniBar{
        id: noteProperties
        property bool postAnonimous: false
        property string expiery: ""
        property int maxTakes: -1
        anchors.top: parent.top

        function composeText(){
            var t = ""
            t = postAnonimous? "Anonimous" : "Signed"
            t += ", "
            t += expiery === ""? "no expiery" : "expire"
            t += ", "
            t += maxTakes === -1? "unlimited" : "limited to " + maxTakes + "takse"
            return t
        }

        onContract: {
            text = composeText()
        }
        Component.onCompleted: text = composeText()

        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            RowLayout {
                height: 96
                anchors.left: parent.left
                anchors.right: parent.right
                Button {
                    Label {text: "Post as yourself"}
                    width: parent.width / 2
                }
                Button {
                    Label {text: "Post as Anonimous"}
                    width: parent.width / 2
                }
            }
            ListItem{
                height: 96
                Label {text: "Never expire"}
            }
            ListItem{
                height: 96
                Label {text: "Allow unlimited takes"}
            }
        }
    }

    EditArea {
        id: noteEdit
        anchors.top: noteProperties.bottom
        focus: true

    }

    ImagePreview
    {
        id: noteAttachment
//        width: page.width /2.0
//        height: page.width /2.0
        anchors.topMargin: 48
        anchors.top: noteEdit.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        //source: "http://animalia-life.com/data_images/dog/dog4.jpg"
    }

}
