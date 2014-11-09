import QtQuick 2.3

import "../scripts/AppStyle.js" as Style

Rectangle {
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------
    anchors.fill: parent
    color: Style.Palette.CYAN
    Timer{
        running: true
        interval: 1000
        onTriggered: app.goToPage(app.pages.Home)
    }
}
