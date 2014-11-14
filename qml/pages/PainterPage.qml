import QtQuick 2.3
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../common/OmniBar" as OmniBar
import "../common/Controls" as Widgets

import "../common"
import Wingo 1.0
Page {
    id: page

    icon: ""
    title: "Painter"
    defaultAction: Style.ACTION_BAR_BACK_ACTION

    onBackButtonClicked: app.goBack()

    Column {
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: 60
            color: "lightgray"
        }

        Rectangle {
            width: parent.width
            height: 60
            color: "white"

            ListModel {
                id:colorModel
                ListElement {colorName:"red"}
                ListElement {colorName:"brown"}
                ListElement {colorName:"blue"}
                ListElement {colorName:"green"}

            }


            ListView {
                id:colorView
                orientation: Qt.Horizontal
                anchors.fill: parent
                model:colorModel
                delegate: Rectangle {
                    width : parent.height
                    height: parent.height
                    color :colorName
                    border.color:  ListView.isCurrentItem ? "black" : "transparent"
                    border.width: 2
                    MouseArea {
                        anchors.fill: parent
                        onClicked: colorView.currentIndex = index
                    }
                }
            }
        }
        PainterItem {
            width : parent.width
            height : parent.width
            penColor:colorModel.get(colorView.currentIndex).colorName
        }
    }











}
