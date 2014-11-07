import QtQuick 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import Wingo 1.0
import "common"
import "scripts/AppStyle.js" as Style

WingoApplication {
    id : app

    initialPage  : Page {

    }

    Rectangle {
        anchors.centerIn: parent
        width:40
        height:50
        MouseArea {
            anchors.fill: parent
            onClicked: app.pageStack.push(test)
        }

        Component {
            id:test
            Page {
            }
        }
    }



}
