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
    Column {
        anchors.top: parent.top
        width: parent.width

        OmniBar{
            id: settingBar
            property bool postAnonimous: false
            property string expiery: "null"
            property int maxTakes: -1
            onContracted: {

            }
        }

      EditArea {
          focus: true

      }


    }

    ImagePreview
    {
        width: page.width /2.0
        height: page.width /2.0
        anchors.verticalCenterOffset: 10
        anchors.centerIn: parent

        //source: "http://animalia-life.com/data_images/dog/dog4.jpg"
    }

}
