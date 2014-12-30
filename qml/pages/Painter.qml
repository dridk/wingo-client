import QtQuick 2.3
import Wingo 1.0
import QtMultimedia 5.4

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar

import "Painter"

Layouts.Page {
    id: page
    property bool videoMode : false

    signal drawChange(string path)

    function back() {
        if (painterItem.save()) {
            page.drawChange("file:///"+painterItem.path())
        }
        app.goBack();
    }

    function loadImage(){
        painterItem.load()
    }

    ActionBar.Widget {
        id: actionBar
        style: Style.PAGE_SPECIAL

        ActionBar.Title {
            icon: Icons.CARRET_LEFT
            text: "Painter"
            onClicked: page.back()
        }

        ActionBar.Right{
            ActionBar.Button {
                icon: Icons.PICTURE_ADD

                onClicked: {
                videoMode = !videoMode

                }
            }
            ActionBar.Button {
                icon: Icons.UNDO
            }
            ActionBar.Button {
                icon: Icons.TRASH
                onClicked: painterItem.clear()
            }
        }
    }

    Column {
        anchors.top: actionBar.bottom
        anchors.topMargin: _RES.s_MARGIN
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: _RES.s_MARGIN

        Toolbar{
            id: toolBar
            onToolChanged: {
                if (tool === t_PEN) painterItem.penColor = colorPicker.color;
                else painterItem.penColor = "white";
            }
            onPenSizeChanged: painterItem.penSize = toolBar.penSize
        }

        Palette{
            id: colorPicker
            onColorChanged: if (toolBar.tool === toolBar.t_PEN) painterItem.penColor = color
        }

        Item{
            width : parent.width
            height : width
            PainterItem {
                id: painterItem
                anchors.fill: parent
                anchors.margins: _RES.s_MARGIN
                penColor: colorPicker.color
                penSize: toolBar.penSize
                visible: !videoMode
            }

            //======== VIDEO MODE ================

            VideoOutput {
                  source: camera
                  anchors.fill: parent
                  anchors.margins: _RES.s_MARGIN
                  visible: videoMode


                  MouseArea {
                      anchors.fill: parent
                      onClicked: camera.imageCapture.capture()
                  }
              }

            Camera {
                  id: camera
                  imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

                  exposure {
                      exposureCompensation: -1.0
                      exposureMode: Camera.ExposurePortrait
                  }

                  flash.mode: Camera.FlashRedEyeReduction

                  imageCapture {
                      onImageSaved:  {
                         painterItem.loadFromPath(path)
                         videoMode = false
                      }
                  }
              }

            //======== END VIDEO MODE ================


        }
    }

}

//    Column {
//        anchors.top : actionBar.toolBar
//        width: parent.width
//        Rectangle {
//            width: parent.width
//            height: 60
//            color: "lightgray"


//            Widgets.Icon {
//                name: Icons.PEN


//            }
//        }

//        Rectangle {
//            width: parent.width
//            height: 60
//            color: "white"

//            ListModel {
//                id:colorModel
//                 ListElement {colorName: "red" }
////                ListElement {colorName: Style.Palette.BLACK }
////                ListElement {colorName: Style.Palette.DEEPSEA }
////                ListElement {colorName: Style.Palette.CYAN }
////                ListElement {colorName: Style.Palette.NIGHTSKY }
////                ListElement {colorName: Style.Palette.MAGENTA }
////                ListElement {colorName: Style.Palette.SUNRISE }
////                ListElement {colorName: Style.Palette.YELLOW }
//            }


//            ListView {
//                id:colorView
//                orientation: Qt.Horizontal
//                model:colorModel
//                anchors.fill: parent
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
//            id: painterItem
//            width : parent.width
//            height : width
//            penColor: colorModel.get(colorView.currentIndex).colorName
//        }
//    }

//}




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
