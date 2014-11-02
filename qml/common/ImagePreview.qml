import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: 210
    height: 210

    property string source: ""

    Image
    {
        id: imgPlaceHolder
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/qml/Res/images/addPicturePlaceholder.png"
        anchors.fill: parent
    }

    Image
    {
        id: imgPreview
        fillMode: Image.PreserveAspectCrop
        source: root.source
        anchors.fill: parent
        anchors.margins: 5
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
