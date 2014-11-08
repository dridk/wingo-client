import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../common/OmniBar" as OmniBarWidget
import "../common/Controls" as Widgets

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

            var post = {
                "lat": app.latitude,
                "lon": app.longitude,
                "author":"darwin", //TIPS... darwin, to make it works without auth
                "anonymous": noteProperties.postAnonimous,
                "message":noteEdit.text
            }

            if (noteProperties.expiery > -1){
                var expiery = new Date();
                var exp = notePropertiesExpieryWidget.model[noteProperties.expiery];
                if (exp.indexOf("day") > 0) {
                    expiery.setDate(expiery.getDate() +  exp.replace(/\D/g,'') );
                }else if (exp.indexOf("Mo") > 0) {
                    expiery.setMonth(expiery.getMonth() +  exp.replace(/\D/g,'') );
                }else if (exp.indexOf("Yr") > 0) {
                    expiery.setYear(expiery.getFullYear() +  exp.replace(/\D/g,'') );
                }
                post["expiration"] = expiery.toISOString();
            }

            if (noteProperties.maxTakes > -1)
                post["limit"] = notePropertiesLimitWidget.model[noteProperties.maxTakes] * 1;

            console.debug("POST NOTE")
            postNoteRequester.post(post)
        }
    }

    OmniBarWidget.OmniBar{
        id: noteProperties
        property bool postAnonimous: false
        property int expiery: -1
        property int maxTakes: -1
        anchors.top: parent.top

        function composeText(){
            var t = ""
            t = postAnonimous? "Anonimous" : "Signed"
            t += ", "
            t += expiery === -1? "no expiery" : "expire in " + notePropertiesExpieryWidget.model[expiery]
            t += ", "
            t += maxTakes === -1? "unlimited" : notePropertiesLimitWidget.model[maxTakes] + " takes"
            return t
        }

        function updateValues() {
            postAnonimous = notePropertiesIdentityWidget.selected === 1;
            expiery = notePropertiesExpieryWidget.selected;
            maxTakes = notePropertiesLimitWidget.selected;
        }

        onPostAnonimousChanged: text = composeText()
        onExpieryChanged: text = composeText()
        onMaxTakesChanged: text = composeText()

        Component.onCompleted: text = composeText()

        OmniBarWidget.MultiSelectListItem{
            id: notePropertiesIdentityWidget
            model: ["Post as yourself", "Post as Anonimous"]
            selected: 0
            onClick: noteProperties.updateValues()
        }

        OmniBarWidget.SectionHeader{
            text: "Note expiery"
        }

        OmniBarWidget.SimpleListItem{
            text: "Never expire"
            Widgets.Checkmark{
                id: widgetNeverExpire
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                checked: true
                onCheckedChanged: notePropertiesExpieryWidget.selected = checked? -1: 0
            }
            onClicked: widgetNeverExpire.toggle()
        }

        OmniBarWidget.MultiSelectListItem{
            id: notePropertiesExpieryWidget
            model: ["1day", "5day", "15day", "1Mo", "6Mo", "1Yr", "3Yr"]
            selected: -1
            enabled: !widgetNeverExpire.checked
            onSelectedChanged: noteProperties.updateValues()
        }

        OmniBarWidget.SectionHeader{
            text: "Allowed Takes"
        }

        OmniBarWidget.SimpleListItem{
            text: "Unlimited"
            Widgets.Checkmark{
                id: widgetUnlimitedTakes
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                checked: true
                onCheckedChanged: notePropertiesLimitWidget.selected = checked? -1: 0
            }
            onClicked: widgetUnlimitedTakes.toggle()
        }

        OmniBarWidget.MultiSelectListItem{
            id: notePropertiesLimitWidget
            model: ["5", "10", "15", "30", "80", "100", "300"]
            selected: -1
            enabled: !widgetUnlimitedTakes.checked
            onSelectedChanged: noteProperties.updateValues()
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
