import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../scripts/AppStyle.js" as Style
import "../common/SideBar" as SideBarWidget
import "../common"

Page {
    id: page
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------
    Column {
        anchors.fill: parent
        ActionBar {
            id:actionBar
            icon: "wingo48"
            title: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"
        }


        HomeOmniBar {

        }


        ListView {
            model: 10
            width: page.width
            height: page.height - actionBar.height
            clip:true

            delegate: NoteListItem{
                message: "salut"
                takes: 5
                nickname: "sacha"
            }
        }
    }

    Rectangle{
        id:footer
        width: parent.width
        height: 64
        color: Qt.rgba(255, 255, 255, 0.95)
        anchors.bottom: parent.bottom
        Label{
            text: "Post new note..."
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            color: Style.Typography.FADE
        }
        MouseArea{
            anchors.fill: parent
            onClicked: app.goToPage(app.pages["AddNote"])
        }
    }

}
