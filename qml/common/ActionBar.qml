import QtQuick 2.3
import QtQuick.Layouts 1.1

Rectangle {
    //Needed for QtCreator design mode
    width: 540
    height: 96
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top

    property string icon: ""
    property string title: ""

    RowLayout{
        anchors.fill: parent

    }
}
