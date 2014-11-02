import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style

Rectangle {
    id: filterBar
    //Needed for QtCreator design mode
    width: 540
    height: 64
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    z: 0

    property variant filter: {
        "byDate": true,
        "byPopularity": false,
        "distance": 50,
        "search": ""
    }

    color: Style.Background.VIEW

    function filterBarSensorLabelText(){
        var t = "";
        if (filter.byDate) {t = "Recent"}
        else if (filter.byPopularity) {t = "Popular"}
        t += " in " + filter.distance + "m radius"
        return t
    }

    function updateFilterBarSensorLabelText(){
        filterBarSensorLabel.text = filterBar.filterBarSensorLabelText()
    }

    function expand(){
        state = "EXPANDED"
    }

    function contract(){
        filterBar.updateFilterBarSensorLabelText()
        state = ""
    }

    MouseArea{
        id: filterBarSensor
        anchors.rightMargin: 8
        anchors.leftMargin: 16
        anchors.fill: parent
        Label{
            id: filterBarSensorLabel
            text: filterBar.filterBarSensorLabelText()
            anchors.verticalCenter: parent.verticalCenter
            Behavior on color {ColorAnimation {}}
        }
        Icon{
            id: filterBarSensorIcon
            name: "expand48"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Behavior on rotation {NumberAnimation{}}
        }
        onClicked: filterBar.state = filterBar.state==="EXPANDED"? "" : "EXPANDED"
    }

    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }

    Rectangle{
        id: filterBarTray
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: 0
        clip: true
        color: Style.Background.VIEW
        Behavior on height {NumberAnimation{}}

        ColumnLayout{
            id: filterBarTrayColumn
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0
            ListItem {
                height: 96
                text: "Recent notes"
                onClicked: {
                    filterBar.filter.byDate = true
                    filterBar.filter.byPopularity = false
                    filterBar.contract()
                }
            }
            ListItem {
                height: 96
                text: "Popular notes"
                onClicked: {
                    filterBar.filter.byDate = false
                    filterBar.filter.byPopularity = true
                    filterBar.contract()
                }
            }
            RowLayout{
                height: 96
                Layout.fillWidth: true
                ListItem {
                    text: "in 5m"
                    Layout.fillWidth: true
                }
                ListItem {
                    text: "in 15m"
                    Layout.fillWidth: true
                }
                ListItem {
                    text: "in 50m"
                    Layout.fillWidth: true
                }
                ListItem {
                    text: "in 100m"
                    Layout.fillWidth: true
                }
            }
        }

    }

    states: [
        State {
            name: "EXPANDED"

            PropertyChanges {
                target: filterBarSensorIcon
                rotation: 180
            }

            PropertyChanges {
                target: filterBarTray
                height: app.height - ( filterBar.y + filterBar.height )
            }

            PropertyChanges {
                target: filterBarSensorLabel
                color: Style.Typography.FADE
            }

            PropertyChanges {
                target: filterBar
                z: 1
            }
        }
    ]
}
