import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 210
    height: 210
    property string source
    //    color: source=="" ? "transparent" : "white"
//    opacity: area.pressed ? 0.2 : 1


        Image
        {
            anchors.fill: parent
            id: imgPreview

            source: root.source =="" ?  "qrc:/qml/Res/images/addPicturePlaceholder.png" : root.source
            opacity: area.pressed ? 0.7 : 1


            MouseArea {
                id:area
                anchors.fill: parent


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
