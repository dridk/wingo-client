import QtQuick 2.3
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar

import "../common"

import "Post"

Layouts.Page {
    id: page

    ActionBar.Widget {
        id: actionBar
        ActionBar.Title {
            icon: Icons.CARRET_LEFT
            text: "Painter"
            onClicked: app.goBack()
        }
        ActionBar.Right{
            ActionBar.Action {
                icon: Icons.LOGO
                onClicked: page.post()
            }
        }
    }

    Column {
        anchors.fill: parent
        Rectangle {
            width: parent.width
            height: 60
            color: "lightgray"


            Widgets.Icon {
                name: Icons.PEN

                Widgets.Button {
                    anchors.fill: parent
                }
            }
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




//Page {
//    id: page

//    icon: ""
//    title: "Painter"
//    defaultAction: Style.ACTION_BAR_BACK_ACTION

//    onBackButtonClicked: app.goBack()

//    Column {
//        anchors.fill: parent
//        Rectangle {
//            width: parent.width
//            height: 60
//            color: "lightgray"


//                Widgets.Icon {
//                    name: Icons.PEN

//                    Button {
//                        anchors.fill: parent
//                    }
//            }
//        }

//        Rectangle {
//            width: parent.width
//            height: 60
//            color: "white"

//            ListModel {
//                id:colorModel
//                ListElement {colorName:"red"}
//                ListElement {colorName:"brown"}
//                ListElement {colorName:"blue"}
//                ListElement {colorName:"green"}

//            }


//            ListView {
//                id:colorView
//                orientation: Qt.Horizontal
//                anchors.fill: parent
//                model:colorModel
//                delegate: Rectangle {
//                    width : parent.height
//                    height: parent.height
//                    color :colorName
//                    border.color:  ListView.isCurrentItem ? "black" : "transparent"
//                    border.width: 2
//                    MouseArea {
//                        anchors.fill: parent
//                        onClicked: colorView.currentIndex = index
//                    }
//                }
//            }
//        }
//        PainterItem {
//            width : parent.width
//            height : parent.width
//            penColor:colorModel.get(colorView.currentIndex).colorName
//        }
//    }











//}
