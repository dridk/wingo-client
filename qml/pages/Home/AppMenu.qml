import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../common/SideBar" as SideBar
import "../../common/Controls" as Widgets

SideBar.Widget {
    id: appMenu


    SideBar.SimpleListItem{
       text : app.logged ? app.currentUser["nickname"]+"<br><small>"+app.currentUser["email"]+"</small>" : "Login"
        onClicked: app.logged ? page.goAccount() :  page.goLogin()

        Widgets.Avatar {
            id: noteAvatar
            source: app.logged ? app.currentUser["avatar"] : ""
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            anchors.rightMargin: _RES.s_BORDER
        }

    }
    SideBar.SectionHeader{text:"Places"}
    SideBar.SimpleListItem{
        text: qsTr("New Note")
        icon: Icons.POST
        enabled: app.logged
        onClicked: page.goPost()
    }
    SideBar.SimpleListItem{
        text: qsTr("My Notes %1").arg(app.currentUser?"("+app.mynote_count+")":"")
        icon: Icons.NOTEBOOK
        enabled: app.logged
        onClicked: page.goMynotes()
    }
    SideBar.SimpleListItem{
        text: qsTr("My Pocket %1").arg(app.currentUser?"("+app.pocket_count+")":"")
        icon: Icons.POCKET
        onClicked: page.goPocket()
        enabled: app.logged
    }
    SideBar.SectionHeader{text:"Options"}
    SideBar.SimpleListItem{
        text: qsTr("App Settings")
        icon: Icons.GEAR
        onClicked: page.goSettings()
    }
    SideBar.SimpleListItem{
        text: qsTr("About")
        icon: Icons.INFO
        onClicked: page.goAbout()
    }
    SideBar.SimpleListItem{
        text: qsTr("Legal")
        icon: Icons.INFO
    }









}


