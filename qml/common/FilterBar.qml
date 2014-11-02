import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0
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
                id:radiusLayoutId
                height: 96
                Layout.fillWidth: true

                Repeater {
                    //ugly... But I want to avoid error message for now
                    model : app.config === undefined ? 0 : app.config.allowed_radius.length
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
//                            filterBar.contract()
                            tagRequester.get({"at": app.latitude+","+app.longitude, "radius":filterBar.distance})
                        }
                    }

                }

            }
        }

//=================THE TAGS LIST ==========================================
        Rectangle {
            anchors.top: filterBarTrayColumn.bottom
            width: parent.width
            height: 500

            Rectangle {
                id:separator
                width: parent.width
                height: 50
                color: "lightgray"

                Label{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    text: "Tags"
                    color: "#46504c"
                }
            }

            Request {
                id:tagRequester
                source:"/tags"
                onSuccess: {
                    tagModel.clear()
                    tagModel.append(data.results)
                }
            }

            ListView {
                anchors.fill: parent
                anchors.topMargin: 50
                model: ListModel{id:tagModel}
                clip:true

                delegate:   Rectangle {
                    height: 54
                    width: parent.width
                    color: area.pressed ? "#00b8cc" : "white"

                    Label{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        text: name
                        color: !area.pressed ? "#00b8cc" : "white"
                    }

                    Label{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 16
                        text: count
                        color: !area.pressed ? "#00b8cc" : "lightgray"

                    }

                    Rectangle{
                        id:lineSeparator
                        width: parent.width
                        height: 1
                        color: "lightgray"
                    }

                    MouseArea{
                        id:area
                        anchors.fill: parent
                        onClicked: filterBar.search=name


                    }

                }
            }
        }
//=================END TAGS LIST ==========================================

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
