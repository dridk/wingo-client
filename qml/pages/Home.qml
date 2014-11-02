import QtQuick 2.0

import "../scripts/AppStyle.js" as Style
import "../common"

Page {
    id: page
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------
    anchors.fill: parent

    icon: "wingo48"
    title: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"
    defaultAction: Style.ACTION_BAR_MENU_ACTION

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

    onMenuButtonClicked: console.log("Menu from Home")
    onActionButtonClicked: {
        console.log("Action button " + name + " clicked at index " + index)
    }

    Rectangle{
        color: "#aa5151"
        width: 100
        height: 100
    }


}
