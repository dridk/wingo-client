import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../common/OmniBar" as OmniBarWidget

import "../common"
import Wingo 1.0
Page {
    id: page

    icon: ""
    title: "Add Note"
    defaultAction: Style.ACTION_BAR_BACK_ACTION

    onBackButtonClicked: app.goBack()

    Component.onCompleted: {
        app.updateLocation()
    }

    actionsListModel: ListModel{
        ListElement {
            icon: "post48"
            name: "post"
            buttonStyle: "ACCENT"
        }
    }

    onActionButtonClicked: {
        if (index == 0)
        {
            console.debug("POST NOTE")
            postNoteRequester.post({
                                  "at":[parseFloat(app.latitude),parseFloat(app.longitude)],
                                  "author":"darwin", //TIPS... darwin, to make it works without auth
                                  "anonymous":true,
                                  "message":noteEdit.text
                                   })
        }
    }

    OmniBarWidget.OmniBar{
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

        OmniBarWidget.MultiSelectListItem{
            model: ["Post as yourself", "Post as Anonimous"]
            selected: 0
            onClick: {
                switch (index) {
                case 0:
                    noteProperties.postAnonimous = true
                    break;
                case 1:
                    noteProperties.postAnonimous = false
                    break;
                }
            }
        }

        OmniBarWidget.SimpleListItem{
            text: "Never expire"
        }
        OmniBarWidget.SimpleListItem{
            text: "Allow unlimited takes"
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

    Text {
        anchors.centerIn: parent
        text: app.latitude+" " + app.longitude
    }

    Request{
        id:postNoteRequester
        source:"/notes"
        onSuccess: {
            app.showMessage("SUCCESS")
        }
        onError: {
            app.showMessage("ERROR " + message)
        }
    }



}
