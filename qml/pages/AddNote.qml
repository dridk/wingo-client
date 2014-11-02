import QtQuick 2.0

import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../common"

Page {
    id: page

    icon: "pocket48"
    title: "Pocket"
    defaultAction: Style.ACTION_BAR_BACK_ACTION

    onBackButtonClicked: app.goBack()

    ColumnLayout{
        anchors.fill: parent

        FilterBar{
            id: filterbar
        }

        ImagePreview
        {
            width: page.width /2.0
            height: page.width /2.0
            anchors.centerIn: parent
            //source: "http://animalia-life.com/data_images/dog/dog4.jpg"
        }
    }

}
