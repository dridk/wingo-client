import QtQuick 2.0

import "../../scripts/AppStyle.js" as Style
import "../"

Rectangle{
    id: listItem
    //Needed for QtCreator design mode
    width: 540
    height: 96
    //-----------
    anchors.left: parent.left
    anchors.right: parent.right

    TextEdit{

    }


    Rectangle{
        height: 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: Style.Border.DEFAULT
    }
}
