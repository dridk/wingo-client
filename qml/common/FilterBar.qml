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

    property bool expanded: filterBarTray.height > 0
    z: expanded ? 99 : 0

    property bool sortByDate: true
    property bool sortByPopularity: false
    property int distance: 50
    property string search: ""

    signal filterChanged

    color: Style.Background.VIEW

    function filterBarSensorLabelText(){
        var t = "";
        if (sortByDate) {t = "Recent"}
        else if (sortByPopularity) {t = "Popular"}
        t += " in " + distance + "m radius"
        return t
    }

    function updateFilterBarSensorLabelText(){
        filterBarSensorLabel.text = filterBar.filterBarSensorLabelText()
    }

    function toggle(){
        if (state == "EXPANDED")  contract()
        else expand()
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
        onClicked: toggle()
    }

    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }

    //Page shadowing effect
    Rectangle
    {
        id: overlay
        color: Style.Background.OVERLAY
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: 0
        opacity: 0
        Behavior on opacity {NumberAnimation{duration: page.backgroundAnimationDuration}}
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
                    filterBar.sortByDate = true
                    filterBar.sortByPopularity = false
                    filterBar.contract()
                }
            }
            ListItem {
                height: 96
                text: "Popular notes"
                onClicked: {
                    filterBar.sortByDate = false
                    filterBar.sortByPopularity = true
                    filterBar.contract()
                }
            }
            RowLayout{
                height: 96
                Layout.fillWidth: true

                Repeater {
                    model : app.config.allowed_radius.length
                    Button {

                        width: filterBar.width / 4
                        height: 96
                        Label{
                            text: "in "+app.config.allowed_radius[index]+"m" ;
                            anchors.horizontalCenter: parent.horizontalCenter;
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Layout.fillWidth: true
                        onClicked: {
                            filterBar.distance = app.config.allowed_radius[index]
                            filterBar.contract()
                        }
                    }


                }


                //                Button {
                //                    id: button1
                //                    width: filterBar.width / 4
                //                    height: 96
                //                    Label{text: "in 5m" ; anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}
                //                    Layout.fillWidth: true
                //                    onClicked: {
                //                        filterBar.distance = 5
                //                        filterBar.contract()
                //                    }
                //                }
                //                Button {
                //                    width: filterBar.width / 4
                //                    height: 96
                //                    Label{text: "in 15m"; anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}
                //                    Layout.fillWidth: true
                //                    onClicked: {
                //                        filterBar.distance = 15
                //                        filterBar.contract()
                //                    }
                //                }
                //                Button {
                //                    width: filterBar.width / 4
                //                    height: 96
                //                    Label{text: "in 50m"; anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}
                //                    Layout.fillWidth: true
                //                    onClicked: {
                //                        filterBar.distance = 50
                //                        filterBar.contract()
                //                    }
                //                }
                //                Button {
                //                    width: filterBar.width / 4
                //                    height: 96
                //                    Label{text: "in 100m"; anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}
                //                    Layout.fillWidth: true
                //                    onClicked: {
                //                        filterBar.distance = 100
                //                        filterBar.contract()
                //                    }
                //                }
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
                target: overlay
                height: app.height - ( filterBar.y + filterBar.height )
                opacity: 1
            }

            PropertyChanges {
                target: filterBarSensorLabel
                color: Style.Typography.FADE
            }
        }
    ]
}
