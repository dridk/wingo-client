import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import Wingo.Material.Controls 0.1
import Wingo.Material.Styles 0.1
import Wingo.Material 0.1


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    color: "#00b8cc"

    Component.onCompleted: {

            Units.pixelDensity = Qt.binding(function() {
                return Screen.pixelDensity
            });
           }






 Button {
     text: "Wingo Material"
     anchors.centerIn: parent
 }



}

