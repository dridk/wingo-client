import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../common/SideBar" as SideBar
import "../../common/Controls" as Widgets
import "../../common/ActionBar" as ActionBar

SideBar.Widget {
    id: appMenu

    ActionBar.Widget{
        style: Style.PAGE_UTILITY
        ActionBar.Title {
            icon: Icons.CARRET_LEFT
            text: "Wingo"
            onClicked: contractTray()
        }
    }
    SideBar.SectionHeader{
        text:"Places"
        visible: app.logged
    }
    SideBar.SimpleListItem{
        text: qsTr("New Note")
        icon: Icons.POST
        visible: app.logged
        onClicked: page.goPost()
    }
    SideBar.SimpleListItem{
        text: qsTr("My Notes %1").arg(app.currentUser?"("+app.mynote_count+")":"")
        icon: Icons.NOTEBOOK
        visible: app.logged
        onClicked: page.goMynotes()
    }
    SideBar.SimpleListItem{
        text: qsTr("My Pocket %1").arg(app.currentUser?"("+app.pocket_count+")":"")
        icon: Icons.POCKET
        onClicked: page.goPocket()
        visible: app.logged
    }
    SideBar.SectionHeader{text:"Options"}
    SideBar.SimpleListItem{
       text : app.logged ? app.currentUser["nickname"]+"<br><small>"+app.currentUser["email"]+"</small>" : "Login"
        onClicked: app.logged ? page.goAccount() :  page.goLogin()

        Widgets.Avatar {
            id: noteAvatar
            width: _RES.s_ICON_SIZE
            source: app.logged ? app.currentUser["avatar"] : "qrc:/qml/Res/images/anonymous.png"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: _RES.s_DOUBLE_MARGIN
            anchors.rightMargin: _RES.s_BORDER
        }

    }
    SideBar.SimpleListItem{
        text: qsTr("Settings")
        icon: Icons.GEAR
        onClicked: page.goSettings()
    }
    SideBar.SimpleListItem{
        text: qsTr("Help & feedback")
        icon: Icons.INFO
        onClicked: page.goAbout()
    }

}


