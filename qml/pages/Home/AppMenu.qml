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
        text: "New Note"
        icon: Icons.POST
        onClicked: page.goPost()
    }
    SideBar.SimpleListItem{
        text: "My Notes"
        icon: Icons.NOTEBOOK
        enabled: app.logged
        onClicked: page.goMynotes()
    }
    SideBar.SimpleListItem{
        text: "My Pocket"
        icon: Icons.POCKET
        onClicked: page.goPocket()
        enabled: app.logged
    }
    SideBar.SectionHeader{text:"Options"}
    SideBar.SimpleListItem{
        text: "App Settings"
        icon: Icons.GEAR
    }
    SideBar.SimpleListItem{
        text: "About"
        icon: Icons.INFO
    }
    SideBar.SimpleListItem{
        text: "Legal"
        icon: Icons.INFO
    }









}


