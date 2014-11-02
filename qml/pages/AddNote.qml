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

        Rectangle{
            color: "#7c1c1c"
            width: 100
            height: 100
        }
    }

}
