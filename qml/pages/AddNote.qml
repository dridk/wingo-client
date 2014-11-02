import QtQuick 2.3

import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../common"

Page {
    id: page

    icon: "Add Note"
    title: "Pocket"
    defaultAction: Style.ACTION_BAR_BACK_ACTION

    onBackButtonClicked: app.goBack()

    actionsListModel: ListModel{
        ListElement {
            icon: "refresh48"
            name: "refresh"
        }
        ListElement {
            icon: "pocket48"
            name: "pocket"
        }
    }
    Column {
        anchors.top: parent.top
        width: parent.width

        FilterBar{
            id: filterbar
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
