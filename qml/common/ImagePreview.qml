import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: 210
    height: 210
    property string source
    //    color: source=="" ? "transparent" : "white"
//    opacity: area.pressed ? 0.2 : 1
    color: "black"


    Rectangle {
        anchors.fill: parent
        color: "red"
        anchors.margins: 5
        Image
        {
            anchors.fill: parent
            id: imgPreview

            source: root.source =="" ?  "qrc:/qml/Res/images/addPicturePlaceholder.png" : root.source



            MouseArea {
                id:area
                anchors.fill: parent

            }
        }


    }
    /*
    DropShadow
    {
        id: rectShadow;
        anchors.fill: root
        cached: true;
        horizontalOffset: 0;
        verticalOffset: 0;
        radius: 8.0;
        samples: 16;
        color: "#80000000";
        smooth: true;
        source: root;
    }*/
}
