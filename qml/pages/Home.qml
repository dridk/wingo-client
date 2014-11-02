import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtPositioning 5.2
import "../scripts/AppStyle.js" as Style
import "../common"

Page {
    id: page

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
        switch (index){
         case 0:
             app.goToPage(app.pages["AddNote"])
             break;
        }
    }

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





    // OGD - GPS Test
    Text
    {
        id: gpsText
        anchors.centerIn: parent
    }

    PositionSource
    {
        id: gpsSource
        updateInterval: 1000
        active: true

        onPositionChanged:
        {
            var coord = gpsSource.position.coordinate;
            console.log("Coordinate:", coord.latitude, coord.longitude);
            gpsText.text = coord.latitude + " " + coord.longitude
        }
    }

}
